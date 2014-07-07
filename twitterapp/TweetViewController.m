//
//  TweetViewController.m
//  twitterapp
//
//  Created by Bharti Agrawal on 7/3/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "TweetViewController.h"
#import "ReplyViewController.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface TweetViewController ()
- (IBAction)onTap:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorScreenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authorImageView;

@end

@implementation TweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tweet";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Configure the right button
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onLoginButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Tweet *tweet = [defaults objectForKey:@"currentTweet"];
    
    NSURL *url = [NSURL URLWithString:tweet.author.profilePicUrl];
    [self.authorImageView setImageWithURL:url];
    self.authorNameLabel.text = tweet.author.name;
    self.tweetTextLabel.text = tweet.text;
    self.authorScreenNameLabel.text = tweet.author.screenName;

    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.navigationController pushViewController:[[ReplyViewController alloc] init] animated:YES];
}
@end
