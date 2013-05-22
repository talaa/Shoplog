//
//  Shoplogactivity.m
//  ttttt
//
//  Created by Tamer Alaa on 10/21/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "Shoplogactivity.h"
#import "TestViewController.h"
#import "ShoplogactivityViewController.h"




@interface Shoplogactivity ()<Shoplogactivityviewcontrollerdelegate>
@property (strong, nonatomic) UIImage *authorImage;
@property (strong, nonatomic) NSString *messagetext;
@property (nonatomic,retain)ShoplogactivityViewController *shoplogactivitycontroller;
@end
@implementation Shoplogactivity
@synthesize selectedthings;

- (UIImage *)activityImage
{
    
    return [UIImage imageNamed:@"MyIcon copy_57 copy_BW" ];
}
- (NSString *)activityTitle
{
    return @"Share with Shoplog";
}
- (NSString *)activityType
{
    //return UIActivityTypeMail;
    return @"com.springmoon.Shoplog.shoploginternal";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    /*
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
     */
    //NSLog(@"The Count of Activity items is %@",activityItems[2]);
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    //ShoplogactivityViewController *vc = [[ShoplogactivityViewController alloc] init];
    selectedthings=[[NSMutableArray alloc]initWithContentsOfURL:activityItems[2]];
    //[vc setShownstuff:selectedthings];
    //NSLog(@"The selected items are %@",selectedthings);
    
    
    /*
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
     */
}
- (UIViewController *)activityViewController
{
    
    ShoplogactivityViewController *vc = [[ShoplogactivityViewController alloc] init];
    //[vc setShownstuff:selectedthings];
    //UIPopoverController *popvc=[[UIPopoverController alloc]initWithContentViewController:vc];
    vc.delegate = self;
    vc.shownstuff=self.selectedthings;
    vc.title=@"Sharing to Shoplog";
    //NSLog(@"The selected items are %@",selectedthings);
    
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    nc.modalPresentationStyle = UIModalPresentationPageSheet;
    return nc;
         
}



- (void)performActivity
{
        NSLog(@"I have Pushed the Shoplog Button");
    [self activityDidFinish:YES];
}

- (void)ShoplogactivityViewControllerDidCancel:(ShoplogactivityViewController *)viewController
{
    
    [self activityDidFinish:YES];
}
   
@end
