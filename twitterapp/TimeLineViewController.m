//
//  TimeLineViewController.m
//  twitterapp
//
//  Created by Bharti Agrawal on 7/3/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "TimeLineViewController.h"
#import "TweetCell.h"
#import "TweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Tweet.h"

@interface TimeLineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tweets;

@end

@implementation TimeLineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Home";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    
    self.tableView.rowHeight = 100;
    
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (TimeLineViewController *) initWithArray:(NSArray *)tweets{
    self.tweets = [Tweet tweetsWithArray:tweets];
    return self;
}

#pragma mark - Table View methods
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRowsInSection: %d", self.tweets.count);
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"cellForRowAtIndexPath: %d", indexPath.row);
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweet = self.tweets[indexPath.row];
    NSURL *url = [NSURL URLWithString:tweet.author.profilePicUrl];
    [cell.authorView setImageWithURL:url];
    cell.authorLabel.text = tweet.author.name;
    cell.textLabel.text = tweet.text;
    cell.authorTabLabel.text = tweet.author.screenName;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath: %d", indexPath.row); // you can see selected row number in your console;
    
    Tweet *tweet = self.tweets[indexPath.row];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:tweet forKey:@"currentTweet"];
    [defaults synchronize];
    
    [self.navigationController pushViewController:[[TweetViewController alloc] init] animated:YES];
}



@end
