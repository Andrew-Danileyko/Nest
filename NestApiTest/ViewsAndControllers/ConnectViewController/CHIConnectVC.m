//
//  CHIConnectVC.m
//  NestApiTest
//
//  Created by Andrew Danileyko on 15/12/15.
//  Copyright © 2015 Andrew Danileyko. All rights reserved.
//

#import "CHIConnectVC.h"
#import "NestAuthManager.h"
#import "Constants.h"

#define QUESTION_MARK @"?"
#define SLASH @"/"
#define HASHTAG @"#"
#define EQUALS @"="
#define AMPERSAND @"&"
#define EMPTY_STRING @""

@interface CHIConnectVC ()

@property (weak, nonatomic) IBOutlet UIWebView *_uiWebView;

-(IBAction)didTouchClose:(id)sender;

@end

@implementation CHIConnectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *authorizationCodeURL = [[NestAuthManager sharedManager] authorizationURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:authorizationCodeURL]];
    [self._uiWebView loadRequest:request];
}

-(IBAction)didTouchClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
