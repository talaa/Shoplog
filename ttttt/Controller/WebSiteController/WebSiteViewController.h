//
//  WebSiteViewController.h
//  ttttt
//
//  Created by Mena Bebawy on 12/14/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebSiteViewController : UIViewController

@property (strong, nonatomic) NSString *webSiteURL;
@property (weak, nonatomic) IBOutlet UIWebView *itemWebView;

@end
