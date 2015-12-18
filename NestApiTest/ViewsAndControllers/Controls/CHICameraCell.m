//
//  CHICameraCell.m
//  NestApiTest
//
//  Created by Andrew Danileyko on 17/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import "CHICameraCell.h"
#import "CHIDeviceCamera.h"

@interface CHICameraCell ()

@property (weak, nonatomic) IBOutlet UISwitch *_uiOnline;
@property (weak, nonatomic) IBOutlet UISwitch *_uiStreaming;
@property (weak, nonatomic) IBOutlet UISwitch *_uiVideoHistory;
@property (weak, nonatomic) IBOutlet UISwitch *_uiAudioInput;
@property (strong, nonatomic) CHIDeviceCamera *_camera;

-(IBAction)didChangeValues:(id)sender;

@end

@implementation CHICameraCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self._uiOnline.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self._uiStreaming.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self._uiVideoHistory.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self._uiAudioInput.transform = CGAffineTransformMakeScale(0.8, 0.8);
}

- (void)updateWithObject:(id)object {
    [super updateWithObject:object];
    self._camera = object;
    self._camera.delegate = self;
    [self updateViews];
}

- (void)updateViews {
    if (self.updateInProgress) return;
    
    self.uiContentView.hidden = (self._camera == nil);
    if (self._camera) {
        self._uiOnline.on = [self._camera.device online];
        self._uiStreaming.on = [self._camera.device streaming];
        self._uiVideoHistory.on = [self._camera.device videoHistoryEnabled];
        self._uiAudioInput.on = [self._camera.device audioInputEnabled];
        self.uiIDLabel.text = [self._camera.device cameraId];
        self.uiNameLabel.text = [self._camera.device nameLong];
    }
}

-(IBAction)didChangeValues:(id)sender {
    [self._camera.device setOnline:self._uiOnline.isOn];
    [self._camera.device setStreaming:self._uiStreaming.isOn];
    [self._camera.device setVideoHistoryEnabled:self._uiVideoHistory.isOn];
    [self._camera.device setAudioInputEnabled:self._uiAudioInput.isOn];
    [self._camera   save];
}

@end
