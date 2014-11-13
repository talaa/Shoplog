//
//  Fancysearch.m
//  ttttt
//
//  Created by Tamer Alaa on 11/7/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "Fancysearch.h"
#import "WebViewController.h"
#import "Flurry.h"



@implementation Fancysearch
- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"Fancy-Logo.png" ];
}
- (NSString *)activityTitle
{
    return @" Search The Fancy";
}
- (NSString *)activityType
{
    return @"com.springmoon.Shoplog.Fancysearch";
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
    NSString *completeUrl=[@"http://www.thefancy.com/search?q=" stringByAppendingString:self.searchstring];
    NSDictionary *flurrydicttionary2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Fancy Search",@"searchengine", nil];
    [Flurry logEvent:@"Search_Engine" withParameters:flurrydicttionary2 timed:YES];

    //[webcontrol setBrowseuuurl:[[NSURL alloc]initWithString:completeUrl]];
    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:completeUrl,@"Searchwebsite",self.searchstring,@"searchstring1",nil];
    // NSDictionary *dict = [NSDictionary dictionaryWithObject:completeUrl forKey:@"Searchwebsite"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"webSearchactivated" object:self userInfo:dict];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:completeUrl]];
    
    [self activityDidFinish:YES];

}
@end
