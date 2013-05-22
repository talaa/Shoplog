//
//  WebdetailViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 4/11/13.
//  Copyright (c) 2013 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebdetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *Fullwebdetail;
@property (strong,nonatomic) IBOutlet UIActivityIndicatorView *showbusyindicator;
@property (strong,nonatomic)NSURL *detailurl;
@end
