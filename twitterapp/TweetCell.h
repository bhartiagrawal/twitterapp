//
//  TweetCell.h
//  twitterapp
//
//  Created by Bharti Agrawal on 7/5/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorTabLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authorView;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
- (IBAction)reply:(id)sender;
- (IBAction)retweet2:(id)sender;

- (IBAction)retweet:(id)sender;
- (IBAction)favorite:(id)sender;
@end
