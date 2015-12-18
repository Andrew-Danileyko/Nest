//
//  CHIDashboardVC.m
//  NestApiTest
//
//  Created by Andrew Danileyko on 15/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import "CHIDashboardVC.h"
#import "NestAuthManager.h"
#import "Constants.h"
#import "CHIConnectVC.h"
#import "CHIDevicesManager.h"

@interface CHIDashboardVC ()

@property (weak, nonatomic) IBOutlet UITextField *_uiPinCode;

@property (weak, nonatomic) IBOutlet UIView *_uiContentView;
@property (weak, nonatomic) IBOutlet UILabel *_uiWaitLabel;
@property (nonatomic) BOOL _authInProgress;

-(IBAction)didTouchLoginWithNest:(id)sender;
-(IBAction)didTouchAuthorize:(id)sender;

@end

@implementation CHIDashboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self._uiContentView.alpha = 0;
    self._authInProgress = NO;
    
    [[NestAuthManager sharedManager] setClientId:NestClientID];
    [[NestAuthManager sharedManager] setClientSecret:NestClientSecret];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoToAuth"]) {
        self._authInProgress = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self._uiWaitLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self._uiContentView.alpha = 1;
            }];
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAccessToken:) name:kNotoficationAccessToken object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString *accessToken = [[NestAuthManager sharedManager] accessToken];
    if (!accessToken) {
        if (!self._authInProgress) {
            [self performSegueWithIdentifier:@"GoToAuth" sender:nil];
        }
    } else {
        [[CHIDevicesManager sharedInstance] setupFirebase];
        [self performSegueWithIdentifier:@"GoToControls" sender:nil];
    }
}

- (void)onAccessToken:(id)sender {
    [[CHIDevicesManager sharedInstance] setupFirebase];
    [self performSegueWithIdentifier:@"GoToControls" sender:nil];
}

-(IBAction)didTouchLoginWithNest:(id)sender {
    [self performSegueWithIdentifier:@"GoToAuth" sender:nil];
}

-(IBAction)didTouchAuthorize:(id)sender {
    [[NestAuthManager sharedManager] setAuthorizationCode:self._uiPinCode.text];
}

@end
