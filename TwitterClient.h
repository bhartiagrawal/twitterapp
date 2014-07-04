//
//  TwitterClient.h
//  twitterapp
//
//  Created by Bharti Agrawal on 6/30/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *) instance;

-(void) login;

- (AFHTTPRequestOperation *)homeTimelineWithSuccess:(void (^) (AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error)) failure;

@end
