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
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoritesLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetedByLabel;
@property (nonatomic, strong) Tweet *tweet;

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

- (TweetViewController *) initWithTweet:(Tweet *)tweet{
    self.tweet = tweet;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Configure the right button
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(reply)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    NSInteger retweetedCount = [self.tweet.retweeted intValue];
    NSInteger favoriteCount = [self.tweet.favorited intValue];
    NSString *retweetedBy = self.tweet.retweetedBy;
    
    NSURL *url = [NSURL URLWithString:self.tweet.author.profilePicUrl];
    [self.authorImageView setImageWithURL:url];
    self.authorNameLabel.text = self.tweet.author.name;
    self.tweetTextLabel.text = self.tweet.text;
    self.authorScreenNameLabel.text = self.tweet.author.screenName;
    self.dateLabel.text = self.tweet.formatedDate;
    self.retweetedLabel.text = [NSString stringWithFormat:@"%d", retweetedCount];
    self.favoritesLabel.text = [NSString stringWithFormat:@"%d", favoriteCount];

    if (retweetedCount <= 0){
        self.retweetedByLabel.text = @"";
    } else if (retweetedBy != nil)
        self.retweetedByLabel.text = [NSString stringWithFormat:@"%@ retweeted", retweetedBy];
    else {
        self.retweetedByLabel.text= [NSString stringWithFormat:@"retweeted"];
    }
    self.retweetedByLabel.text = self.tweet.retweetedBy;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reply{
    
    ReplyViewController *vc = [[ReplyViewController alloc] initWithTweet:self.tweet];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onTap:(id)sender {
    ReplyViewController *vc = [[ReplyViewController alloc] initWithTweet:self.tweet];
    
    [self.navigationController pushViewController:vc animated:YES];

}
@end
