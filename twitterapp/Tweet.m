//
//  Tweet.m
//  twitterapp
//
//  Created by Bharti Agrawal on 7/6/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "Tweet.h"
#import "TwitterClient.h"

//code copied from
//https://github.com/questbeat/Categories/blob/master/iOS/NSURL%2BdictionaryFromQueryString/NSURL%2BdictionaryFromQueryString.m
//
@implementation NSURL (dictionaryFromQueryString)

- (NSDictionary *)dictionaryFromQueryString
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    NSArray *pairs = [[self query] componentsSeparatedByString:@"&"];
    
    for(NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dictionary setObject:val forKey:key];
    }
    
    return dictionary;
}

@end

@implementation Tweet

static Tweet *currentTweet = nil;
static NSArray *tweets = nil;

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

+(NSArray *) getTweets{
    return tweets;
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
    //NSDate *today = [[NSDate alloc] init];

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


//
// Code copied from
//https://github.com/bdbergeron/BDBOAuth1Manager
//

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([url.scheme isEqualToString:@"cptwitter"])
    {
        if ([url.host isEqualToString:@"oauth"])
        {
            NSDictionary *parameters = [url dictionaryFromQueryString];
            if (parameters[@"oauth_token"] && parameters[@"oauth_verifier"]){
                TwitterClient * client = [TwitterClient instance];
                [client fetchAccessTokenWithPath:@"/oauth/access_token"
                                          method:@"POST"
                                    requestToken:[BDBOAuthToken tokenWithQueryString:url.query]
                                         success:^(BDBOAuthToken *accessToken) {
                                             NSLog(@"Access token");
                                             [client.requestSerializer saveAccessToken:accessToken];
                                             
                                             [client homeTimelineWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
                                                 NSLog(@"response: %@", responseObject);
                                                 NSArray *tweetsArray = responseObject;
                                                 tweets = [Tweet tweetsWithArray:tweetsArray];
                                                 
                                             }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                                 NSLog(@"response error");
                                             }];
                                             
                                         }failure:^(NSError *error){
                                             NSLog(@"access failure");
                                         }];
            }
        }
        return YES;
    }
    return NO;
}


+ (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweetsArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweetsArray addObject:tweet];
    }
    return tweetsArray;
}

+ (NSArray *) reloadTweets{
    NSURL *url = [[NSURL alloc] initWithString:@"cptwitter/oauth"];
    //__block NSArray *tweets;
    if ([url.scheme isEqualToString:@"cptwitter"])
    {
        if ([url.host isEqualToString:@"oauth"])
        {
            NSDictionary *parameters = [url dictionaryFromQueryString];
            if (parameters[@"oauth_token"] && parameters[@"oauth_verifier"]){
                TwitterClient * client = [TwitterClient instance];
                [client fetchAccessTokenWithPath:@"/oauth/access_token"
                                          method:@"POST"
                                    requestToken:[BDBOAuthToken tokenWithQueryString:url.query]
                                         success:^(BDBOAuthToken *accessToken) {
                                             NSLog(@"Access token");
                                             [client.requestSerializer saveAccessToken:accessToken];
                                             
                                             [client homeTimelineWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
                                                 NSLog(@"response: %@", responseObject);
                                                 NSArray *tweetsArray = responseObject;
                                                 tweets = [Tweet tweetsWithArray:tweetsArray];
                                                 
                                             }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                                 NSLog(@"response error");
                                             }];
                                             
                                         }failure:^(NSError *error){
                                             NSLog(@"access failure");
                                         }];
            }
        }
        //return YES;
    }
    return tweets;
}
                


@end
