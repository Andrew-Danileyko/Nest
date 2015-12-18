//
//  CHINestDevice.h
//  NestApiTest
//
//  Created by Andrew Danileyko on 16/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NestDeviceManager.h"

@class CHINestDevice;

@protocol CHINestDeviceProtocol <NSObject>

- (void)deviceDidChangeParameters:(CHINestDevice *)device;

@end

@interface CHINestDevice : NSObject <NestDeviceManagerDelegate>

@property (weak, nonatomic) id<CHINestDeviceProtocol> delegate;
@property (strong, nonatomic) NSString *deviceId;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *locationName;
@property (strong, nonatomic) NestDeviceManager *manager;
@property (strong, nonatomic) id device;
@property (nonatomic) BOOL shouldBeDeleted;

+ (CHINestDevice *)deviceWithDeviceId:(NSString *)deviceId type:(NSString *)type;
- (instancetype)initWithDeviceId:(NSString *)deviceId type:(NSString *)type;
- (void)updateWithDictionary:(NSDictionary *)dictionary;
- (void)save;

@end
