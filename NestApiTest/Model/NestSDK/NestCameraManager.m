//
//  NestCameraManager.m
//  NestApiTest
//
//  Created by Andrew Danileyko on 17/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import "NestCameraManager.h"
#import "NestAuthManager.h"
#import "FirebaseManager.h"
#import "Constants.h"

@implementation NestCameraManager

- (void)beginSubscriptionForDevice:(id)device {
    Camera *camera = device;
    [[FirebaseManager sharedManager] addSubscriptionToURL:[NSString stringWithFormat:@"devices/cameras/%@/", camera.cameraId] withBlock:^(FDataSnapshot *snapshot) {
        [self updateDevice:camera forStructure:snapshot.value];
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

    Camera *camera = device;
    if ([structure objectForKey:DEVICE_ID]) {
        camera.cameraId = [structure objectForKey:DEVICE_ID];
    }
    if ([structure objectForKey:IS_AUDIO_INPUT_DEVICE]) {
        camera.audioInputEnabled = [[structure objectForKey:IS_AUDIO_INPUT_DEVICE] boolValue];
    }
    if ([structure objectForKey:IS_ONLINE]) {
        camera.online = [[structure objectForKey:IS_ONLINE] boolValue];
    }
    if ([structure objectForKey:IS_STREAMING]) {
        camera.streaming = [[structure objectForKey:IS_STREAMING] boolValue];
    }
    if ([structure objectForKey:IS_VIDEO_HYSTORY_ENABLED]) {
        camera.videoHistoryEnabled = [[structure objectForKey:IS_VIDEO_HYSTORY_ENABLED] boolValue];
    }
    if ([structure objectForKey:LAST_EVENT]) {
        camera.lastEvent = [structure objectForKey:LAST_EVENT];
    }
    if ([structure objectForKey:NAME_LONG]) {
        camera.nameLong = [structure objectForKey:NAME_LONG];
    }
    [self.delegate deviceValuesChanged:camera];
}

/**
 * Sets the thermostat values by using the Firebase API.
 * @param thermostat The thermost you wish to save.
 * @see https://www.firebase.com/docs/transactions.html
 */
- (void)saveChangesForDevice:(id)device {
    Camera *camera = device;
    NSMutableDictionary *values = [[NSMutableDictionary alloc] init];
    
    values[IS_ONLINE] = @(camera.online);
    values[IS_STREAMING] = @(camera.streaming);
    values[IS_VIDEO_HYSTORY_ENABLED] = @(camera.videoHistoryEnabled);
    values[IS_AUDIO_INPUT_DEVICE] = @(camera.audioInputEnabled);
    
    [[FirebaseManager sharedManager] setValues:values forURL:[NSString stringWithFormat:@"%@/%@/", CAMERA_PATH, camera.cameraId]];
}
@end
