//
//  TwitterClient.h
//  twitterapp
//
//  Created by Bharti Agrawal on 6/29/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface RottenTomatoesClient : AFHTTPRequestOperationManager

+ (RottenTomatoesClient *) instance;

- (AFHTTPRequestOperation *)boxOfficeWithSuccess:(void (^) (AFHTTPRequestOperation *operation, NSArray *movies))success failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error)) failure;

@end
