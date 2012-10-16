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
@interface CreateShoplogTagImage : NSObject



@property (nonatomic,strong) Shoplog *shoplog;
- (UIImage*)Imagetag:(Shoplog*)selecteditem;
@end
