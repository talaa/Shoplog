//
//  UIPopover+Iphone.m
//  ttttt
//
//  Created by Tamer Alaa on 9/30/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "UIPopover+Iphone.h"

@implementation UIPopoverController (overrides)

+ (BOOL)_popoversDisabled {
    return NO;
}

@end