//
//  CHIControllsCell.m
//  NestApiTest
//
//  Created by Andrew Danileyko on 16/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import "CHIControllsCell.h"

@implementation CHIControllsCell

- (void)awakeFromNib {
    self.updateInProgress = NO;
    self.uiContentView.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithObject:(id)object {
}

- (IBAction)beginUpdate:(id)sender {
    self.updateInProgress = YES;
}

- (IBAction)endUpdate:(id)sender {
    self.updateInProgress = NO;
}

- (void)updateViews {
    
}

#pragma mark - CHINestDevice Protocol

- (void)deviceDidChangeParameters:(CHINestDevice *)device {
    [self updateViews];
}

@end
