//
//  User.h
//  twitterapp
//
//  Created by Bharti Agrawal on 7/3/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *profilePicUrl;
@property (nonatomic, strong) NSString *location;

+(User *)currentUser;

+(void)setCurrentUser:(User *)user;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)usersWithArray:(NSArray *)array;

@end
