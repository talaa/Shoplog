//
//  Shoplog.h
//  ttttt
//
//  Created by Tamer Alaa on 11/5/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ExtendedManagedObject.h"

@interface Shoplog : ExtendedManagedObject

@property (nonatomic, retain) NSString * categoryname;
@property (nonatomic, retain) NSString * comments;
@property (nonatomic) NSTimeInterval date;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSDecimalNumber * phone;
@property (nonatomic) float price;
@property (nonatomic) int16_t rating;
@property (nonatomic, retain) NSString * shop;
@property (nonatomic, retain) NSString * websiteurl;

@end
