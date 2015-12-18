//
//  CHINestDevice.m
//  NestApiTest
//
//  Created by Andrew Danileyko on 16/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import "CHINestDevice.h"
#import "CHIDeviceThermostat.h"
#import "CHIDeviceCamera.h"
#import "CHIDeviceSmoke.h"
#import "Constants.h"

@implementation CHINestDevice

+ (CHINestDevice *)deviceWithDeviceId:(NSString *)deviceId type:(NSString *)type {
    Class deviceClass = [CHINestDevice class];
    if ([type isEqualToString:kDeviceCamera]) {
        deviceClass = [CHIDeviceCamera class];
    }
    if ([type isEqualToString:kDeviceSmoke]) {
        deviceClass = [CHIDeviceSmoke class];
    }
    if ([type isEqualToString:kDeviceThermostat]) {
        deviceClass = [CHIDeviceThermostat class];
    }
    
    return [[deviceClass alloc] initWithDeviceId:deviceId type:type];
}

- (instancetype)initWithDeviceId:(NSString *)deviceId type:(NSString *)type {
    self = [super init];
    
    if (self) {
        self.deviceId = deviceId;
        self.type = type;
    }
    
    return self;
}

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    
}

- (void)save {
    [self.manager saveChangesForDevice:self.device];
}

- (void)deviceValuesChanged:(id)device {
    if ([self.delegate respondsToSelector:@selector(deviceDidChangeParameters:)]) {
        [self.delegate deviceDidChangeParameters:self];
    }
}

@end
