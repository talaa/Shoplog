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
@synthesize browseuuurl,Mainwebview;
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
- (void)viewDidLoad
{
    [Mainwebview loadRequest:[NSURLRequest requestWithURL:browseuuurl]];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
