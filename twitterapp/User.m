//
//  User.m
//  twitterapp
//
//  Created by Bharti Agrawal on 7/3/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "User.h"

@implementation User

static User *currentUser = nil;

+(User *)currentUser{
    if (currentUser == nil){
        NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"current_user"];
        if (dictionary){
            //currentUser = [[User alloc] initWithDictionary:dictionary];
        }
    }
    return currentUser;
}

+(void)setCurrentUser:(User *)user{
    currentUser = user;
    
    //save to UserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentUser forKey:@"current_user"];
    [defaults synchronize];
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.profilePicUrl = dictionary[@"profile_image_url_https"];
        self.location = dictionary[@"location"];
    }
    
    return self;
}

+ (NSArray *)usersWithArray:(NSArray *)array {
    NSMutableArray *users = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array) {
        User *user = [[User alloc] initWithDictionary:dictionary];
        [users addObject:user];
    }
    
    return users;
}

@end
