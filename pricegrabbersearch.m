//
//  pricegrabbersearch.m
//  ttttt
//
//  Created by Tamer Alaa on 4/17/13.
//  Copyright (c) 2013 Tamer Alaa. All rights reserved.
//

#import "pricegrabbersearch.h"
#import "Flurry.h"

@implementation pricegrabbersearch
- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"PriceGrabber.png" ];
}
- (NSString *)activityTitle
{
    return @"Search PriceGrabber";
}
- (NSString *)activityType
{
    return @"com.springmoon.Shoplog.pricegrabber";
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (int i = 0; i < activityItems.count; i++)
    {
        id item = activityItems[i];
        if ([item class] == [UIImage class] || [item
                                                isKindOfClass:[NSString class]])
        {
        }
        else
        {
            return NO;
        }
    }
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (int i = 0; i < activityItems.count; i++)
    {
        id item = activityItems[i];
        if ([item class] == [UIImage class])
        {
            self.authorImage = item;
        }
        else if ([item isKindOfClass:[NSString class]])
        {self.searchstring = item;
        }
    }
}

-(void)performActivity{
    
    NSString *completeUrl=[[NSString alloc]initWithFormat:@"http://www.pricegrabber.com/%@/products.html/form_keyword=%@",self.searchstring,self.searchstring ];
    NSDictionary *flurrydicttionary2=[[NSDictionary alloc]initWithObjectsAndKeys:@"PriceGrabber",@"searchengine", nil];
    [Flurry logEvent:@"Search_Engine" withParameters:flurrydicttionary2 timed:YES];
     NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:completeUrl,@"Searchwebsite",self.searchstring,@"searchstring1",nil];
    //NSDictionary *dict = [NSDictionary dictionaryWithObject:completeUrl forKey:@"Searchwebsite"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"webSearchactivated" object:self userInfo:dict];
    [self activityDidFinish:YES];
    
}

@end
