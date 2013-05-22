//
//  ShoplogactivityViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 5/21/13.
//  Copyright (c) 2013 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol Shoplogactivityviewcontrollerdelegate;

@interface ShoplogactivityViewController : UIViewController

@property (weak,nonatomic)id<Shoplogactivityviewcontrollerdelegate>delegate;
@property (nonatomic,retain)NSMutableArray *shownstuff;
@end

@protocol Shoplogactivityviewcontrollerdelegate <NSObject>

-(void)ShoplogactivityViewControllerDidCancel:(ShoplogactivityViewController*)viewcontroller;


@end