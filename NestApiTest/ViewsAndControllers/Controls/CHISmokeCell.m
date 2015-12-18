//
//  CHISmokeCell.m
//  NestApiTest
//
//  Created by Andrew Danileyko on 17/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import "CHISmokeCell.h"
#import "CHIDeviceSmoke.h"

@interface CHISmokeCell ()

@property (weak, nonatomic) IBOutlet UILabel *_uiCoAlarmState;
@property (weak, nonatomic) IBOutlet UILabel *_uiSmokeAlarmState;
@property (weak, nonatomic) IBOutlet UILabel *_uiBatteryHealth;
@property (weak, nonatomic) IBOutlet UISwitch *_uiManual;
@property (strong, nonatomic) CHIDeviceSmoke *_smoke;

@end

@implementation CHISmokeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)updateWithObject:(id)object {
    [super updateWithObject:object];
    self._smoke = object;
    self._smoke.delegate = self;
    [self updateViews];
}

- (void)updateViews {
    if (self.updateInProgress) return;
    
    self.uiContentView.hidden = (self._smoke == nil);
    if (self._smoke) {
        self._uiCoAlarmState.text = [self._smoke.device coAlarmState];
        self._uiSmokeAlarmState.text = [self._smoke.device smokeAlarmState];
        self._uiBatteryHealth.text = [self._smoke.device batteryHealth];
        self._uiManual.on = [self._smoke.device isManualTestActive];
        self.uiIDLabel.text = [self._smoke.device smokeId];
        self.uiNameLabel.text = [self._smoke.device nameLong];
    }
}

@end
