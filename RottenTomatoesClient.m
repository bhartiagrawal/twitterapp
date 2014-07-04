//
//  TwitterClient.m
//  twitterapp
//
//  Created by Bharti Agrawal on 6/29/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "RottenTomatoesClient.h"

@implementation RottenTomatoesClient


+ (RottenTomatoesClient *) instance {
    static RottenTomatoesClient *instance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        instance = [[RottenTomatoesClient alloc] init];
    });
    return instance;
}

-(AFHTTPRequestOperation *)boxOfficeWithSuccess:(void (^)(AFHTTPRequestOperation *, NSArray *))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    return [self GET:@"box_office" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSArray *moviesJsonArray = responseObject[@"movies"];
        //NSArray *movies = [Movie moviesWithJsonArray:moviesJsonArray];
        //success(operation, movies);
    } failure:failure];
}

@end
