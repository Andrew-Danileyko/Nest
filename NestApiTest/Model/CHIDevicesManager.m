//
//  CHIDevicesManager.m
//  NestApiTest
//
//  Created by Andrew Danileyko on 16/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import "CHIDevicesManager.h"
#import "NestAuthManager.h"
#import "FirebaseManager.h"
#import "CHINestDevice.h"
#import "Constants.h"

static CHIDevicesManager *manager;

@interface CHIDevicesManager ()

@property (strong, nonatomic) NSDictionary *_locations;
@property (strong, nonatomic) NSArray *_deviceTypes;

@end

@implementation CHIDevicesManager

+ (CHIDevicesManager *)sharedInstance {
    if (!manager) {
        manager = [[CHIDevicesManager alloc] init];
    }
    
    return manager;
}

- (void)setFirebaseConnected:(int)firebaseConnected {
    _firebaseConnected = firebaseConnected;
    if (firebaseConnected == kFirebaseStateConnected) {
        [self subscribeDevices];
    }
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.firebaseConnected = kFirebaseStateNotConnected;
        self._deviceTypes = @[kDeviceCamera, kDeviceSmoke, kDeviceThermostat];
        self.structureLoaded = NO;
        self.devicesLoaded = NO;
    }
    
    return self;
}

- (NSString *)deviceTypeWithDeviceId:(NSString *)deviceId {
    for (NSString *key in [self.structure allKeys]) {
        NSDictionary *devices = self.structure[key];
        id device = devices[deviceId];
        if (device) {
            return key;
        }
    }
    return nil;
}

- (void)updateStructureWithDeviceType:(NSString *)deviceType value:(NSDictionary *)value {
    NSArray *devices = value[deviceType];
    if (devices) {
        for (NSString *deviceId in devices) {
            NSMutableDictionary *devices = self.structure[deviceType];
            devices[deviceId] = deviceId;
        }
    }
}

- (void)subscribeDevices {
    self.devices = [NSMutableDictionary dictionary];
    [[FirebaseManager sharedManager] addSubscriptionToURL:@"structures" withBlock:^(FDataSnapshot *snapshot) {
        self.structure = [NSMutableDictionary dictionary];
        for (NSString *key in self._deviceTypes) {
            self.structure[key] = [NSMutableDictionary dictionary];
        }
        for (FDataSnapshot *child in snapshot.children) {
            NSDictionary *value = child.value;
            self._locations = value[@"wheres"];
            for (NSString *deviceType in self._deviceTypes) {
                [self updateStructureWithDeviceType:deviceType value:value];
            }
        }
        self.structureLoaded = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:kFirebaseSnapshotNotification object:nil];
    }];
    [[FirebaseManager sharedManager] addSubscriptionToURL:@"devices" withBlock:^(FDataSnapshot *snapshot) {
        for (CHINestDevice *device in [self.devices allValues]) {
            device.shouldBeDeleted = YES;
        }
        for (FDataSnapshot *child in snapshot.children) {
            for (NSDictionary *value in [child.value allObjects]) {
                NSString *deviceId = value[@"device_id"];
                CHINestDevice *device = self.devices[deviceId];
                if (!device) {
                    NSString *deviceType = [self deviceTypeWithDeviceId:deviceId];
                    device = [CHINestDevice deviceWithDeviceId:deviceId type:deviceType];
                    self.devices[deviceId] = device;
                }
                [device updateWithDictionary:value];
                device.shouldBeDeleted = NO;
            }
            for (NSString *key in [self.devices allKeys]) {
                CHINestDevice *device = self.devices[key];
                if (device.shouldBeDeleted) {
                    [self.devices removeObjectForKey:key];
                }
            }
        }
        self.devicesLoaded = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:kFirebaseSnapshotNotification object:nil];
    }];
}

- (void)setupFirebase {
    NSLog(@"access token: %@", [[NestAuthManager sharedManager] accessToken]);
    self.firebaseConnected = kFirebaseStateInProgress;
    [[FirebaseManager sharedManager].rootFirebase authWithCredential:[[NestAuthManager sharedManager] accessToken] withCompletionBlock:^(NSError *error, id data) {
        if (!error) {
            self.firebaseConnected = kFirebaseStateConnected;
        } else {
            self.firebaseConnected = kFirebaseStateNotConnected;
        }
    } withCancelBlock:^(NSError *error) {
        self.firebaseConnected = kFirebaseStateNotConnected;
    }];
}

- (NSArray *)devicesWithType:(NSString *)type {
    NSMutableArray *array = [NSMutableArray array];
    for (CHINestDevice *device in [self.devices allValues]) {
        if ([device.type isEqualToString:type]) {
            [array addObject:device];
        }
    }
    return array;
}

@end
