//
//  UserObject.m
//  ttttt
//
//  Created by Mena Bebawy on 12/3/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import "UserObject.h"

@implementation UserObject

- (instancetype)initWithObject:(PFUser *)user{
    self  = [super self];
    if (self){
        self.name = user[@"name"];
        self.username = user.username;
        self.email = user.email;
        self.gender = user[@"gender"];
        self.birthDate = user[@"birthDate"];
        self.country = user[@"country"];
        PFFile *imageFile = user[@"image"];
        self.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageFile.url]];
    }
    return self;
}
@end
