//
//  ECommerceWebViewController.m
//  ttttt
//
//  Created by Mena Bebawy on 12/19/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import "ECommerceWebViewController.h"

@interface ECommerceWebViewController () <UIWebViewDelegate>

@end

@implementation ECommerceWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.ecommerceTitle;
    
    self.ecommerceWebView.delegate = self;
    [self.activityIdicator startAnimating];
    NSURL *url = [NSURL URLWithString:self.ecommerceURLString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.ecommerceWebView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/********************************************/
//              Web View Delegate           //
/*******************************************/

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    self.activityIdicator.hidden = YES;
    [self.activityIdicator stopAnimating];
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
