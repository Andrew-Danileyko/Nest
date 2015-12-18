//
//  NestSmokeManager.m
//  NestApiTest
//
//  Created by Andrew Danileyko on 17/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import "NestSmokeManager.h"
#import "NestAuthManager.h"
#import "FirebaseManager.h"
#import "Constants.h"

@implementation NestSmokeManager

- (void)beginSubscriptionForDevice:(id)device {
    Smoke *smoke = device;
    [[FirebaseManager sharedManager] addSubscriptionToURL:[NSString stringWithFormat:@"devices/smoke_co_alarms/%@/", smoke.smokeId] withBlock:^(FDataSnapshot *snapshot) {
        [self updateDevice:smoke forStructure:snapshot.value];
    }];
}

/**
 * Parse thermostat structure and put it in the thermostat object.
 * Then send the updated object to the delegate.
 * @param thermostat The thermostat you wish to update.
 * @param structure The structure you wish to update the thermostat with.
 */
- (void)updateDevice:(id)device forStructure:(NSDictionary *)structure
{
    if (!structure || [structure isKindOfClass:[NSNull class]]) return;

    Smoke *smoke = device;
    if ([structure objectForKey:DEVICE_ID]) {
        smoke.smokeId = [structure objectForKey:DEVICE_ID];
    }
    if ([structure objectForKey:CO_ALARM_STATE]) {
        smoke.coAlarmState = [structure objectForKey:CO_ALARM_STATE];
    }
    if ([structure objectForKey:SMOKE_ALARM_STATE]) {
        smoke.smokeAlarmState = [structure objectForKey:SMOKE_ALARM_STATE];
    }
    if ([structure objectForKey:BATTERY_HEALTH]) {
        smoke.batteryHealth = [structure objectForKey:BATTERY_HEALTH];
    }
    if ([structure objectForKey:MANUAL_TEST]) {
        smoke.isManualTestActive = [[structure objectForKey:MANUAL_TEST] boolValue];
    }
    if ([structure objectForKey:NAME_LONG]) {
        smoke.nameLong = [structure objectForKey:NAME_LONG];
    }
    [self.delegate deviceValuesChanged:smoke];
}

/**
 * Sets the thermostat values by using the Firebase API.
 * @param thermostat The thermost you wish to save.
 * @see https://www.firebase.com/docs/transactions.html
 */
- (void)saveChangesForDevice:(id)device {
    Smoke *smoke = device;
    NSMutableDictionary *values = [[NSMutableDictionary alloc] init];
    
    [[FirebaseManager sharedManager] setValues:values forURL:[NSString stringWithFormat:@"%@/%@/", SMOKE_PATH, smoke.smokeId]];
}
@end
