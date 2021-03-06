//
//  LoginViewController.m
//  twitterapp
//
//  Created by Bharti Agrawal on 6/30/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TimeLineViewController.h"

@interface LoginViewController ()
- (IBAction)onLoginButton:(id)sender;

@property (nonatomic, strong) NSArray *tweets;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //[self onLoginButton:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginButton:(id)sender {
    [[TwitterClient instance] login];
}

@end
