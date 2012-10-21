//
//  Shoplogactivity.m
//  ttttt
//
//  Created by Tamer Alaa on 10/21/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "Shoplogactivity.h"




@interface Shoplogactivity ()
@property (strong, nonatomic) UIImage *authorImage;
@property (strong, nonatomic) NSString *funFactText;
@end
@implementation Shoplogactivity


- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"shoppin.png" ];
}
- (NSString *)activityTitle
{
    return @"Send to Shoplog";
}
- (NSString *)activityType
{
    return @"com.domainname.ShopLog.shoploginternal";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
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
        {
            self.funFactText = item;
        }
    }
}
- (void)performActivity
{
    
    NSLog(@"I have Pushed the Shoplog Button");
    
}

@end
