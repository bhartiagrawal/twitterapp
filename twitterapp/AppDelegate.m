//
//  AppDelegate.m
//  twitterapp
//
//  Created by Bharti Agrawal on 6/29/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TwitterClient.h"
#import "ContainerViewController.h"

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

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //self.window.rootViewController = [[LoginViewController alloc] init];
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    self.nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = self.nvc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
                                                 NSArray *tweets = responseObject;
                                                 ContainerViewController *cvc = [[ContainerViewController alloc]initWithArray:tweets];
                                                 [self.nvc pushViewController:cvc animated:YES];
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

@end
