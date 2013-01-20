//
//  GoogleShoppingSearch.m
//  ttttt
//
//  Created by Tamer Alaa on 11/18/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "GoogleShoppingSearch.h"
#import "Flurry.h"

@implementation GoogleShoppingSearch
- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"Google_shopping_logo3.png" ];
}
- (NSString *)activityTitle
{
    return @"Search Google Shopping";
}
- (NSString *)activityType
{
    return @"com.springmoon.Shoplog.GoogleShopping";
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
    NSString *completeUrl=[[NSString alloc]initWithFormat:@"http://www.google.com/search?hl=en&tbm=shop&q=%@&oq=%@&gs_l=products-cc.3..0l10.6805.7477.0.7621.4.4.0.0.0.0.14.46.4.4.0...0.0...1ac.1.aCtXZ4XuJ_0",self.searchstring,self.searchstring ];
    //[webcontrol setBrowseuuurl:[[NSURL alloc]initWithString:completeUrl]];
    NSDictionary *flurrydicttionary2=[[NSDictionary alloc]initWithObjectsAndKeys:@"GoogleShoopingSearch",@"searchengine", nil];
    [Flurry logEvent:@"Search_Engine" withParameters:flurrydicttionary2 timed:YES];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:completeUrl]];
    [self activityDidFinish:YES];
    
}


@end
