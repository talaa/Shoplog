//
//  UserObject.h
//  ttttt
//
//  Created by Mena Bebawy on 12/3/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface UserObject : NSObject

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *birthDate;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSData *imageData;
@property (strong, nonatomic) NSString *name;

- (instancetype)initWithObject:(PFUser*)user;

@end
