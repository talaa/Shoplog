//
//  Shoplog.h
//  ttttt
//
//  Created by Tamer Alaa on 11/14/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ExtendedManagedObject.h"
@class Shop;

@interface Shoplog : ExtendedManagedObject

@property (nonatomic, retain) NSString * categoryname;
@property (nonatomic, retain) NSString * parseid;
@property (nonatomic, retain) NSString * comments;
@property (nonatomic) NSDate *date;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSData * image2;
@property (nonatomic, retain) NSData * image3;
@property (nonatomic, retain) NSDecimalNumber * phone;
@property (nonatomic) float price;
@property (nonatomic) int16_t rating;
@property (nonatomic, retain) NSString * websiteurl;
@property (nonatomic, retain) NSString * dim_size;
@property (nonatomic, retain) Shop *shop;

@end
