//
//  Shoplog.h
//  ttttt
//
//  Created by Tamer Alaa on 9/25/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Shoplog : NSManagedObject

@property (nonatomic, retain) NSString * categoryname;
@property (nonatomic) float price;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * shop;
@property (nonatomic, retain) NSDecimalNumber * phone;
@property (nonatomic, retain) NSString * websiteurl;
@property (nonatomic, retain) NSString * comments;
@property (nonatomic, retain) NSString * email;
@property (nonatomic) NSTimeInterval date;

@end
