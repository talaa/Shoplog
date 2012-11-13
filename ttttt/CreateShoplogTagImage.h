//
//  CreateShoplogTagImage.h
//  ttttt
//
//  Created by Tamer Alaa on 10/16/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Shoplog.h"
#import "Shop.h"
@interface CreateShoplogTagImage : NSObject



@property (nonatomic,strong) Shoplog *shoplog;
@property (nonatomic,strong)Shop *shop;
- (UIImage*)Imagetag:(Shoplog*)selecteditem;
@end
