//
//  WebViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 11/6/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "WebViewController.h"
#import "DetailPopViewController.h"
@interface WebViewController ()

@end

@implementation WebViewController
@synthesize browseuuurl,Mainwebview,thetitle,webnavigation;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)Goingback:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    

     webnavigation.tintColor = [UIColor colorWithRed:48.0f/255.0f green:74.0f/255.0f blue:147.0f/255.0f alpha:1];

}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    NSLog(@"The Url is %@",browseuuurl);
    //NSString *thenewUrl=[[NSString alloc]init];
    
    // Do any additional setup after loading the view.
    webnavigation.topItem.title=thetitle;
    [Mainwebview loadRequest:[NSURLRequest requestWithURL:browseuuurl]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
