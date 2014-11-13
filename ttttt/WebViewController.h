//
//  WebViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 11/6/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *Mainwebview;
@property (nonatomic,strong) NSString *newbrowseurl;
@property (strong,nonatomic)NSURL *browseuuurl;
@property (weak, nonatomic) IBOutlet UINavigationBar *webnavigation;
@property (strong,nonatomic)IBOutlet UIActivityIndicatorView *busyactive;
@property(strong,nonatomic)NSString *thetitle;
@end
