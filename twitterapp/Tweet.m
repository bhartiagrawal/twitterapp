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
        self.age = [self formattedDate:dictionary[@"created_at"]];
        self.formatedDate = dictionary[@"created_at"];
        self.retweeted = dictionary[@"retweeted"];
        self.favorited = dictionary[@"favorited"];
        if (dictionary[@"retweeted_status"] != nil){
            self.retweetedBy = dictionary[@"retweeted_status"][@"user_mentions"][@"screen_name"];
        }
    }
    
    return self;
}

- (NSString *)formattedDate:(NSString *)dateStr
{
    //"Sun Jul 06 00:35:15 +0000 2014"
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"EEE MMM dd hh:mm:ss zzzz yyyy"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    //NSLog(@"%@",date);
    NSDate *today = [[NSDate alloc] init];

    NSTimeInterval timeSinceDate = [[NSDate date] timeIntervalSinceDate:date];
    
    // print up to 24 hours as a relative offset
    if(timeSinceDate < 24.0 * 60.0 * 60.0)
    {
        NSUInteger hoursSinceDate = (NSUInteger)(timeSinceDate / (60.0 * 60.0));
        
        switch(hoursSinceDate)
        {
            default:
                return [NSString stringWithFormat:@"%dh", hoursSinceDate];
            case 1:
                return @"1h";
            case 0:
                ;
                NSUInteger minutesSinceDate = (NSUInteger)(timeSinceDate / 60.0);
                return [NSString stringWithFormat:@"%dm", minutesSinceDate];
                break;
        }
    }
    else
    {
        /* normal NSDateFormatter stuff here */
    }
    return @"";
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
