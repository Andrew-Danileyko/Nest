//
//  CHIControlsTVC.m
//  NestApiTest
//
//  Created by Andrew Danileyko on 16/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import "CHIControlsTVC.h"
#import "CHIControllsCell.h"
#import "CHIDevicesManager.h"
#import <Firebase/Firebase.h>
#import "Constants.h"

#define kTypeTitle 0
#define kTypeCellIdentifier 1

@interface CHIControlsTVC ()

@property (strong, nonatomic) id _selectedDevice;

@end

@implementation CHIControlsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self._selectedDevice = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDevicesLoaded:) name:kFirebaseSnapshotNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)onDevicesLoaded:(id)sender {
    if ([CHIDevicesManager sharedInstance].structureLoaded && [CHIDevicesManager sharedInstance].devicesLoaded) {
        [self.tableView reloadData];
    }
}

- (NSString *)valueByKey:(NSString *)key type:(int)type {
    switch (type) {
        case kTypeTitle: {
            if ([key isEqualToString:kDeviceCamera]) {
                return @"Cameras";
            }
            if ([key isEqualToString:kDeviceSmoke]) {
                return @"Alarms";
            }
            if ([key isEqualToString:kDeviceThermostat]) {
                return @"Thermostats";
            }
        } break;
            
        case kTypeCellIdentifier: {
            if ([key isEqualToString:kDeviceCamera]) {
                return @"CameraCell";
            }
            if ([key isEqualToString:kDeviceSmoke]) {
                return @"SmokeCell";
            }
            if ([key isEqualToString:kDeviceThermostat]) {
                return @"ThermostatCell";
            }
        } break;
    }
    return @"";
}

- (id)deviceWithIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [[CHIDevicesManager sharedInstance].structure allKeys][indexPath.section];
    NSDictionary *deviceIds = [CHIDevicesManager sharedInstance].structure[key];
    NSString *deviceId = [deviceIds allValues][indexPath.row];
    id device = [CHIDevicesManager sharedInstance].devices[deviceId];
    return device;
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [[CHIDevicesManager sharedInstance].structure allKeys][section];
    return [self valueByKey:key type:kTypeTitle];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[CHIDevicesManager sharedInstance].structure allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [[CHIDevicesManager sharedInstance].structure allKeys][section];
    NSDictionary *deviceIds = [CHIDevicesManager sharedInstance].structure[key];
    return [deviceIds allValues].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id device = [self deviceWithIndexPath:indexPath];
    if ([[device deviceId] isEqualToString:[self._selectedDevice deviceId]]) {
        return 200;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [[CHIDevicesManager sharedInstance].structure allKeys][indexPath.section];
    NSString *cellIdentifier = [self valueByKey:key type:kTypeCellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    id device = [self deviceWithIndexPath:indexPath];
    [(CHIControllsCell *)cell updateWithObject:device];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self._selectedDevice = [self deviceWithIndexPath:indexPath];
    [self.tableView reloadData];
}

@end
