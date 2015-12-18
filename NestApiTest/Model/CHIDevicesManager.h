//
//  CHIDevicesManager.h
//  NestApiTest
//
//  Created by Andrew Danileyko on 16/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFirebaseStateNotConnected 0
#define kFirebaseStateConnected 1
#define kFirebaseStateInProgress 2

#define kFirebaseStatusChangedNotification @"kFirebaseStatusChangedNotification"
#define kFirebaseSnapshotNotification @"kDevicesLoadedNotification"

@class FDataSnapshot;

@interface CHIDevicesManager : NSObject

@property (nonatomic) int firebaseConnected;
@property (strong, nonatomic) NSMutableDictionary *structure;
@property (strong, nonatomic) NSMutableDictionary *devices;
@property (nonatomic) BOOL structureLoaded;
@property (nonatomic) BOOL devicesLoaded;

+ (CHIDevicesManager *)sharedInstance;
- (void)setupFirebase;
- (NSArray *)devicesWithType:(NSString *)type;

@end
