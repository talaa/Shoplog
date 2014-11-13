//
//  Shoppingcom.m
//  ttttt
//
//  Created by Tamer Alaa on 4/17/13.
//  Copyright (c) 2013 Tamer Alaa. All rights reserved.
//

#import "Shoppingcom.h"
#import "Flurry.h"


@implementation Shoppingcom
- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"Shoppingcom" ];
}
- (NSString *)activityTitle
{
    return @"Search Shopping.com";
}
- (NSString *)activityType
{
    return @"com.springmoon.Shoplog.shoppingcom";
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
    NSString *completeUrl=[[NSString alloc]initWithFormat:@"http://www.shopping.com/%@/products?CLT=SCH&KW=%@",self.searchstring,self.searchstring ];
    NSDictionary *flurrydicttionary2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Shopping.com",@"searchengine", nil];
    [Flurry logEvent:@"Search_Engine" withParameters:flurrydicttionary2 timed:YES];
     NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:completeUrl,@"Searchwebsite",self.searchstring,@"searchstring1",nil];
    //NSDictionary *dict = [NSDictionary dictionaryWithObject:completeUrl forKey:@"Searchwebsite"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"webSearchactivated" object:self userInfo:dict];
    [self activityDidFinish:YES];
    
}


@end
