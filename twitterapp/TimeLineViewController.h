//
//  TimeLineViewController.h
//  twitterapp
//
//  Created by Bharti Agrawal on 7/3/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLineViewController : UIViewController <UITableViewDataSource>

- (TimeLineViewController *) initWithArray:(NSArray *)tweets;

@end
