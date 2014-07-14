//
//  ReplyViewController.m
//  twitterapp
//
//  Created by Bharti Agrawal on 7/5/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "ReplyViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ReplyViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *authorPicView;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *authorScreenName;
@property (nonatomic, strong) Tweet *tweet;


@end

@implementation ReplyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Reply";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *url = [NSURL URLWithString:self.tweet.author.profilePicUrl];
    [self.authorPicView setImageWithURL:url];
    self.authorName.text = self.tweet.author.name;
    self.authorScreenName.text = self.tweet.author.screenName;

}

- (ReplyViewController *) initWithTweet:(Tweet *)tweet{
    self.tweet = tweet;
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
