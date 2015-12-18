//
//  Camera.h
//  NestApiTest
//
//  Created by Andrew Danileyko on 17/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Camera : NSObject

@property (nonatomic, strong) NSString *cameraId;
@property (strong, nonatomic) NSString *nameLong;
@property (nonatomic) BOOL online;
@property (nonatomic) BOOL streaming;
@property (nonatomic) BOOL videoHistoryEnabled;
@property (nonatomic) BOOL audioInputEnabled;
@property (nonatomic) NSDictionary *lastEvent;

@end
