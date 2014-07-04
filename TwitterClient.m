//
//  TwitterClient.m
//  twitterapp
//
//  Created by Bharti Agrawal on 6/30/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "TwitterClient.h"

@implementation TwitterClient

+ (TwitterClient *) instance {
    static TwitterClient *instance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com"] consumerKey:@"jYCWywrgd4rZakM9sQ2XkEDuj" consumerSecret:@"5v50e8xk5WVeOW4Wu3sFIeFiyyKAeBumhcJYdIANsNGIxGhflz"];
    });
    return instance;
}

- (void) login{
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"POST" callbackURL:[NSURL URLWithString:@"cptwitter://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
        NSString *authURL = [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authURL]];
        NSLog(@"Got request token!");
    } failure:^(NSError *error) {
         NSLog(@"failure: %@", [error description]);
     }];
}

- (AFHTTPRequestOperation *)homeTimelineWithSuccess:(void (^)(AFHTTPRequestOperation *, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    return [self GET:@"1.1/statuses/home_timeline.json" parameters:nil success:success failure:failure];
}


@end
