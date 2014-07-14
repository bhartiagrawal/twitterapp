//
//  Tweet.h
//  twitterapp
//
//  Created by Bharti Agrawal on 7/6/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "user.h"

@interface Tweet : NSObject

@property (nonatomic, strong) User *author;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *retweeted;
@property (nonatomic, strong) NSString *retweetedBy;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *formatedDate;
@property (nonatomic, strong) NSString *favorited;
//@property (nonatomic, strong) __block NSMutableArray *tweets;

+(Tweet *)currentTweet;

+(void)setCurrentTweet:(Tweet *)tweet;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)tweetsWithArray:(NSArray *)array;
+ (NSArray *)reloadTweets;

@end
