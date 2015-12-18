//
//  CHIDeviceThermostat.m
//  NestApiTest
//
//  Created by Andrew Danileyko on 16/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import "CHIDeviceThermostat.h"

@interface CHIDeviceThermostat ()

@end

@implementation CHIDeviceThermostat

- (instancetype)initWithDeviceId:(NSString *)deviceId type:(NSString *)type {
    self = [super initWithDeviceId:deviceId type:type];
    
    if (self) {
        self.device = [[Thermostat alloc] init];
    }
    
    return self;
}

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    [super updateWithDictionary:dictionary];
    
    if (!self.manager) {
        self.manager = [[NestThermostatManager alloc] init];
        self.manager.delegate = self;
        [self.manager updateDevice:self.device forStructure:dictionary];
        [self.manager beginSubscriptionForDevice:self.device];
    } else {
        [self.manager updateDevice:self.device forStructure:dictionary];
    }
}

@end
