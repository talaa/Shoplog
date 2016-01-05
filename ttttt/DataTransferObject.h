//
//  NSObject+DataTransferObject.h
//  ttttt
//
//  Created by Tamer Alaa on 12/28/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTransferObject : NSObject

@property (strong, nonatomic) NSString *defcatqr;
@property (strong, nonatomic) NSString *defimagenameqr;
@property (strong, nonatomic) NSString *defshopname;
@property (strong, nonatomic) NSString *defdimsize;
@property (strong, nonatomic) NSString *defemail;
@property (strong, nonatomic) NSString *defcomments;
@property (strong, nonatomic) NSString *defwebsiteurl;
@property (strong, nonatomic) NSString *defphone;
@property (nonatomic) double deflong;
@property (nonatomic) double deflat;
@property (nonatomic) float defprice;
@property (nonatomic) int defrating;

+ (DataTransferObject*)getInstance;

@end