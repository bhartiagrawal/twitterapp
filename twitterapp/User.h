//
//  User.h
//  twitterapp
//
//  Created by Bharti Agrawal on 7/3/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

+(User *)currentUser;

+(void)setCurrentUser:(User *)user;

@end
