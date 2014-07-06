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
    self.tweets = tweets;
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
    
    NSDictionary *tweet = self.tweets[indexPath.row];
    
    NSString *imageUrl = tweet[@"user"][@"profile_image_url"];
    NSURL *url = [NSURL URLWithString:imageUrl];
    [cell.authorView setImageWithURL:url];

    cell.authorLabel.text = tweet[@"user"][@"name"];
    cell.textLabel.text = tweet[@"text"];
    
    NSString *handle = [NSString stringWithFormat:@"@%@",tweet[@"user"][@"screen_name"]];
    cell.authorTabLabel.text = handle;
    
    //"Sun Jul 06 00:35:15 +0000 2014"
    NSString *dateString = tweet[@"created_at"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"DDD MMM d hh:mm:ss +0000 yyyy"];
    NSDate *dateFromString = nil;
    dateFromString = [dateFormatter dateFromString:dateString];
    NSLog(@"%@",dateFromString);
    NSDate *today = [[NSDate alloc] init];
    //cell.ageLabel.text = [NSString alloc] initWithFormat:@"%d",[[today timeIntervalSinceDate:dateFromString] ];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath: %d", indexPath.row); // you can see selected row number in your console;
    
    NSDictionary *tweet = self.tweets[indexPath.row];
    NSString *name = tweet[@"posters"][@"original"];
    NSString *text = tweet[@"user"][@"text"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:name forKey:@"name"];
    [defaults setObject:text forKey:@"description"];
    [defaults synchronize];
    
    [self.navigationController pushViewController:[[TweetViewController alloc] init] animated:YES];
}



@end
