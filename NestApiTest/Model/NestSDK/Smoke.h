//
//  Smoke.h
//  NestApiTest
//
//  Created by Andrew Danileyko on 17/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Smoke : NSObject

@property (nonatomic, strong) NSString *smokeId;
@property (nonatomic) BOOL isManualTestActive;
@property (nonatomic, strong) NSString *nameLong;
@property (nonatomic, strong) NSString *coAlarmState;
@property (nonatomic, strong) NSString *smokeAlarmState;
@property (nonatomic, strong) NSString *batteryHealth;

@end
