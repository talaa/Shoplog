//
//  Shoplogactivity.h
//  ttttt
//
//  Created by Tamer Alaa on 10/21/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Shoplogactivity : UIActivity
// 1
- (UIImage *)activityImage;
// 2
- (NSString *)activityTitle;
// 3
- (NSString *)activityType;
// 4
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems;
// 5
- (void)prepareWithActivityItems:(NSArray *)activityItems;
// 6
- (void)performActivity;
@end
