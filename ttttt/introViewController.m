//
//  introViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 5/25/13.
//  Copyright (c) 2013 Tamer Alaa. All rights reserved.
//

#import "introViewController.h"
#import "LAWalkthroughViewController.h"

@interface introViewController ()

@end

@implementation introViewController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (void)createWalkthrough
{
    // Create the walkthrough view controller
    LAWalkthroughViewController *walkthrough = LAWalkthroughViewController.new;
    walkthrough.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    walkthrough.backgroundImage = [UIImage imageNamed:@"demo2"];
    
    // Create pages of the walkthrough
    //[walkthrough addPageWithBody:@"Take a tour of this app."];
    //[walkthrough addPageWithBody:@"Thanks for taking this tour."];
    
    // Use the default next button
    walkthrough.nextButtonText = nil;
    
    // Add the walkthrough view to your view controller's view
    [self addChildViewController:walkthrough];
    [self.view addSubview:walkthrough.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self createWalkthrough];
    
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
