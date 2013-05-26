//
//  EBaySearch.m
//  ttttt
//
//  Created by Tamer Alaa on 11/7/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "EBaySearch.h"
#import "Flurry.h"

@implementation EBaySearch
- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"ebay-logo-01.png" ];
}
- (NSString *)activityTitle
{
    return @"Search E-Bay";
}
- (NSString *)activityType
{
    return @"com.springmoon.Shoplog.EBaysearch";
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
    //WebViewController *webcontrol=[[WebViewController alloc]init];
    //NSString *completeUrl=[@"http://www.thefancy.com/search?q=" stringByAppendingString:self.searchstring];
    NSString *completeUrl=[[NSString alloc]initWithFormat:@"http://www.ebay.com/sch/i.html?_trksid=p5197.m570.l1313&_nkw=%@&_sacat=0&_from=R40",self.searchstring ];
    NSDictionary *flurrydicttionary2=[[NSDictionary alloc]initWithObjectsAndKeys:@"EBAY",@"searchengine", nil];
    [Flurry logEvent:@"Search_Engine" withParameters:flurrydicttionary2 timed:YES];

    NSDictionary *dict = [NSDictionary dictionaryWithObject:completeUrl forKey:@"Searchwebsite"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"webSearchactivated" object:self userInfo:dict];
    [self activityDidFinish:YES];
    
}

@end
