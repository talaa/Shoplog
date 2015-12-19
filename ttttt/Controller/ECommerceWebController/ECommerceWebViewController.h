//
//  ECommerceWebViewController.h
//  ttttt
//
//  Created by Mena Bebawy on 12/19/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECommerceWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *ecommerceWebView;
@property (strong, nonatomic) NSString *ecommerceTitle;
@property (strong, nonatomic) NSString *ecommerceURLString;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIdicator;

@end
