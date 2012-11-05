//
//  Shoplogactivity.m
//  ttttt
//
//  Created by Tamer Alaa on 10/21/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "Shoplogactivity.h"
#import "TestViewController.h"




@interface Shoplogactivity ()
@property (strong, nonatomic) UIImage *authorImage;
@property (strong, nonatomic) NSString *funFactText;
@property (strong,nonatomic) NSMutableArray *Selectedthings;
@end
@implementation Shoplogactivity


-(void)setSelectedthings:(NSMutableArray *)Selectedthings{

   // NSLog(@"the Selected Arrays are %@",Selectedthings);


}


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
    return UIActivityTypeMail;
    //return @"com.domainname.ShopLog.shoploginternal";
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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Shoplog.slog"];
    NSLog(@"The String of the Path is :%@",filePath);
    NSData *savedData = [NSKeyedArchiver archivedDataWithRootObject:self.Selectedthings];
    [savedData writeToFile:filePath atomically:YES];
    
    //testitemprovider *gg=[[testitemprovider alloc]init];
    
    //[self.Selectedthings writeToFile:filePath atomically:YES];
    //TestViewController *test=[[TestViewController alloc]init];
    NSLog(@"I have Pushed the Shoplog Button");
    //NSURL *turl=[[NSURL alloc]initFileURLWithPath:filePath];
    //[test.addarray addObject:turl];
   
    
    //[test showmailcomposer:savedData];
    [self activityDidFinish:YES];
}
   
@end
