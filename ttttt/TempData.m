//
//  TempData.m
//  ttttt
//
//  Created by Tamer Alaa on 9/27/15.
//  Copyright (c) 2015 Tamer Alaa. All rights reserved.
//

#import "TempData.h"
static NSUInteger tempcount=0;
@implementation TempData
+(void)setShoplogscount:(NSUInteger)newcount{
    tempcount=newcount;

}
+(NSUInteger) count{
    return tempcount;

}
@end
