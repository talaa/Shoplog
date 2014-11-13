//
//  Rakutensearch.m
//  ttttt
//
//  Created by Tamer Alaa on 11/18/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "Rakutensearch.h"
#import "Flurry.h"

@implementation Rakutensearch
- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"Rakuten2.png" ];
}
- (NSString *)activityTitle
{
    return @"Search Rakuten";
}
- (NSString *)activityType
{
    return @"com.springmoon.Shoplog.Rakuten";
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
    NSString *completeUrl=[@"http://global.rakuten.com/en/search?st=&tl=0&k=" stringByAppendingString:self.searchstring];
    //NSString *completeUrl=[[NSString alloc]initWithFormat:@"http://www.ebay.com/sch/i.html?_trksid=p5197.m570.l1313&_nkw=%@&_sacat=0&_from=R40",self.searchstring ];
    //[webcontrol setBrowseuuurl:[[NSURL alloc]initWithString:completeUrl]];
    NSDictionary *flurrydicttionary2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Rakuten",@"searchengine", nil];
    [Flurry logEvent:@"Search_Engine" withParameters:flurrydicttionary2 timed:YES];
 NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:completeUrl,@"Searchwebsite",self.searchstring,@"searchstring1",nil];
    //NSDictionary *dict = [NSDictionary dictionaryWithObject:completeUrl forKey:@"Searchwebsite"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"webSearchactivated" object:self userInfo:dict];
    [self activityDidFinish:YES];
    
}


@end
