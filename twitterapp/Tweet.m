//
//  Tweet.m
//  twitterapp
//
//  Created by Bharti Agrawal on 7/6/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

static Tweet *currentTweet = nil;

+(Tweet *)currentTweet{
    if (currentTweet == nil){
        NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"current_tweet"];
        if (dictionary){
            //currentUser = [[User alloc] initWithDictionary:dictionary];
        }
    }
    return currentTweet;
}

+(void)setCurrentTweet:(Tweet *)tweet{
    currentTweet = tweet;
    
    //save to UserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentTweet forKey:@"current_tweet"];
    [defaults synchronize];
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.author = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        
        //"Sun Jul 06 00:35:15 +0000 2014"
        NSString *dateString = dictionary[@"created_at"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        [dateFormatter setDateFormat:@"DDD MMM d hh:mm:ss +0000 yyyy"];
        NSDate *dateFromString = nil;
        dateFromString = [dateFormatter dateFromString:dateString];
        NSLog(@"%@",dateFromString);
        NSDate *today = [[NSDate alloc] init];
        //NSTimeInterval *age = [today timeIntervalSinceDate:dateFromString];
        
        //self.age = [NSString alloc] initWithFormat:@"%d",[[today timeIntervalSinceDate:dateFromString] ];
    }
    
    return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    
    return tweets;
}


@end
