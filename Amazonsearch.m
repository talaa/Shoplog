//
//  Amazonsearch.m
//  ttttt
//
//  Created by Tamer Alaa on 11/7/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "Amazonsearch.h"
#import "Flurry.h"

@implementation Amazonsearch
- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"amazon-logo.png" ];
}
- (NSString *)activityTitle
{
    return @"Search Amazon";
}
- (NSString *)activityType
{
    return @"com.springmoon.Shoplog.Amazonsearch";
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
    NSString *completeUrl=[@"http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=" stringByAppendingString:self.searchstring];
    NSDictionary *flurrydicttionary2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Amazon",@"searchengine", nil];
    [Flurry logEvent:@"Search_Engine" withParameters:flurrydicttionary2 timed:YES];

    //[webcontrol setBrowseuuurl:[[NSURL alloc]initWithString:completeUrl]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:completeUrl]];
    [self activityDidFinish:YES];
    
}

@end
