//
//  nexttagsearch.m
//  ttttt
//
//  Created by Tamer Alaa on 4/17/13.
//  Copyright (c) 2013 Tamer Alaa. All rights reserved.
//

#import "nexttagsearch.h"
#import "Flurry.h"

@implementation nexttagsearch
- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"NT_logo_LG_COL" ];
}
- (NSString *)activityTitle
{
    return @"Search Nextag";
}
- (NSString *)activityType
{
    return @"com.springmoon.Shoplog.nextagsearch";
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
    NSString *completeUrl=[[NSString alloc]initWithFormat:@"http://www.nextag.com/%@/compare-html",self.searchstring ];
    NSDictionary *flurrydicttionary2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Nextag",@"searchengine", nil];
    [Flurry logEvent:@"Search_Engine" withParameters:flurrydicttionary2 timed:YES];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:completeUrl forKey:@"Searchwebsite"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"webSearchactivated" object:self userInfo:dict];
    [self activityDidFinish:YES];
    
}


@end
