//
//  Shoplogitemsource.m
//  ttttt
//
//  Created by Tamer Alaa on 10/26/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "Shoplogitemsource.h"

@implementation Shoplogitemsource
- (id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"%@", activityType);
    return [super activityViewController:activityViewController itemForActivityType:activityType];
}

@end
