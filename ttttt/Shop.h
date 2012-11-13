//
//  Shop.h
//  ttttt
//
//  Created by Tamer Alaa on 11/6/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ExtendedManagedObject.h"
@class Shoplog;

@interface Shop : ExtendedManagedObject

@property (nonatomic, retain) NSString * shopname;
@property (nonatomic) double longcoordinate;
@property (nonatomic) double latcoordinate;
@property (nonatomic, retain) Shoplog *shopdetails;

@end
