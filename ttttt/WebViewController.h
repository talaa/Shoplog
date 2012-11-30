//
//  WebViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 11/6/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *Mainwebview;
@property (strong,nonatomic)NSURL *browseuuurl;
@property (weak, nonatomic) IBOutlet UINavigationBar *webnavigation;
@property(strong,nonatomic)NSString *thetitle;
@end
