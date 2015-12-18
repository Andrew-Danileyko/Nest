//
//  NestDeviceManager.h
//  NestApiTest
//
//  Created by Andrew Danileyko on 17/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NestDeviceManager;

@protocol NestDeviceManagerDelegate <NSObject>

- (void)deviceValuesChanged:(id)device;

@end

@interface NestDeviceManager : NSObject

@property (nonatomic, strong) id <NestDeviceManagerDelegate>delegate;

- (void)updateDevice:(id)device forStructure:(NSDictionary *)structure;
- (void)beginSubscriptionForDevice:(id)device;
- (void)saveChangesForDevice:(id)device;

@end
