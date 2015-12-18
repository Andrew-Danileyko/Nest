//
//  CHIControllsCell.h
//  NestApiTest
//
//  Created by Andrew Danileyko on 16/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHINestDevice.h"

@interface CHIControllsCell : UITableViewCell <CHINestDeviceProtocol>

@property (weak, nonatomic) IBOutlet UILabel *uiNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *uiIDLabel;
@property (weak, nonatomic) IBOutlet UIView *uiContentView;
@property (nonatomic) BOOL updateInProgress;
@property (nonatomic) BOOL opened;

- (void)updateWithObject:(id)object;
- (IBAction)beginUpdate:(id)sender;
- (IBAction)endUpdate:(id)sender;
- (void)updateViews;

@end
