//
//  WebdetailViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 4/11/13.
//  Copyright (c) 2013 Tamer Alaa. All rights reserved.
//

#import "WebdetailViewController.h"

@interface WebdetailViewController ()

@end

@implementation WebdetailViewController
@synthesize Fullwebdetail,detailurl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [Fullwebdetail loadRequest:[NSURLRequest requestWithURL:detailurl]];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
