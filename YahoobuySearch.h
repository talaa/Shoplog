//
//  YahoobuySearch.h
//  ttttt
//
//  Created by Tamer Alaa on 11/18/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YahoobuySearch : UIActivity
@property (strong, nonatomic) UIImage *authorImage;
@property (strong, nonatomic) NSString *searchstring;

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
