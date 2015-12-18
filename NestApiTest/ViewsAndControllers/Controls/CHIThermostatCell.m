//
//  CHIThermostatCell.m
//  NestApiTest
//
//  Created by Andrew Danileyko on 16/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import "CHIThermostatCell.h"
#import "CHIDeviceThermostat.h"
#import "Constants.h"

@interface CHIThermostatCell ()

@property (weak, nonatomic) IBOutlet UISwitch *_uiFan;
@property (weak, nonatomic) IBOutlet UISwitch *_uiFanTimer;
@property (weak, nonatomic) IBOutlet UISlider *_uiTemp1;
@property (weak, nonatomic) IBOutlet UISlider *_uiTemp2;
@property (strong, nonatomic) CHIDeviceThermostat *_thermostat;

-(IBAction)didChangeValues:(id)sender;

@end

@implementation CHIThermostatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self._uiFan.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self._uiFan.userInteractionEnabled = NO;
    self._uiFanTimer.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self._uiFanTimer.userInteractionEnabled = NO;
    self._uiTemp1.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self._uiTemp1.userInteractionEnabled = NO;
    self._uiTemp2.transform = CGAffineTransformMakeScale(0.8, 0.8);
}

- (void)updateWithObject:(id)object {
    [super updateWithObject:object];
    self._thermostat = object;
    self._thermostat.delegate = self;
    [self updateViews];
}

- (void)updateViews {
    if (self.updateInProgress) return;
    
    self.uiContentView.hidden = (self._thermostat == nil);
    if (self._thermostat) {
        self._uiTemp1.maximumValue = [self._thermostat.device ambientTemperatureHighF];
        self._uiTemp1.minimumValue = [self._thermostat.device ambientTemperatureLowF];
        self._uiTemp1.value = [self._thermostat.device ambientTemperatureF];
        self._uiTemp2.maximumValue = [self._thermostat.device targetTemperatureHighF];
        self._uiTemp2.minimumValue = [self._thermostat.device targetTemperatureLowF];
        self._uiTemp2.value = [self._thermostat.device targetTemperatureF];
        self.uiIDLabel.text = [self._thermostat.device thermostatId];
        self.uiNameLabel.text = [self._thermostat.device nameLong];
        self._uiFan.on = [self._thermostat.device hasFan];
        self._uiFanTimer.on = [self._thermostat.device fanTimerActive];
    }
}

-(IBAction)didChangeValues:(id)sender {
    [self._thermostat.device setAmbientTemperatureF:self._uiTemp1.value];
    [self._thermostat.device setTargetTemperatureF:self._uiTemp2.value];
    [self._thermostat.device setHasFan:self._uiFan.isOn];
    [self._thermostat.device setFanTimerActive:self._uiFanTimer.isOn];
    [self._thermostat save];
}

@end
