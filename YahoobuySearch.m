//
//  YahoobuySearch.m
//  ttttt
//
//  Created by Tamer Alaa on 11/18/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "YahoobuySearch.h"
#import "Flurry.h"
@implementation YahoobuySearch
- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"yahoologo.png" ];
}
- (NSString *)activityTitle
{
    return @"Search Yahoo Buy";
}
- (NSString *)activityType
{
    return @"com.springmoon.Shoplog.Yahoobuy";
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
    //NSString *completeUrl=[@"http://global.rakuten.com/en/search?st=&tl=0&k=" stringByAppendingString:self.searchstring];
    NSString *completeUrl=[[NSString alloc]initWithFormat:@"http://shopping.yahoo.com/search;_ylt=ApaFjLjy42XZwaG.jCu1u7MEgFoB?p=%@&did=0",self.searchstring ];
    //[webcontrol setBrowseuuurl:[[NSURL alloc]initWithString:completeUrl]];
    NSDictionary *flurrydicttionary2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Yahoobuysearch",@"searchengine", nil];
    [Flurry logEvent:@"Search_Engine" withParameters:flurrydicttionary2 timed:YES];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:completeUrl]];
    [self activityDidFinish:YES];
    
}


@end
