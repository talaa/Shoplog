//
//  ShoplogactivityViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 5/21/13.
//  Copyright (c) 2013 Tamer Alaa. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ShoplogactivityViewController.h"

@interface ShoplogactivityViewController ()

-(void)handleCancel;
-(void)gotocommunity;
@end

@implementation ShoplogactivityViewController
//@synthesize shownstuff;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor purpleColor];
        self.view.layer.cornerRadius = 20.0;
        self.view.layer.frame=CGRectMake(30,30, 150, 150);
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
      
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(gotocommunity)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(handleCancel)];
    [self.navigationController setToolbarHidden:NO];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationController.toolbar.tintColor = [UIColor darkGrayColor];
    [self configurestandardview];
    
}
-(void)viewDidAppear:(BOOL)animated{
//NSLog(@"Testingarray is %@",[_shownstuff[0] valueForKey:@"categoryname"]);

[self configureview];

}
-(void)configurestandardview{
    CALayer *sublayer = [CALayer layer];
    sublayer.frame = sublayer.bounds;
    sublayer.masksToBounds = YES;
    sublayer.contents = (id) [UIImage imageNamed:@"MyIcon copy_57"].CGImage;
    sublayer.shadowOffset = CGSizeMake(0, 3);
    sublayer.cornerRadius=5;
    sublayer.shadowRadius = 5.0;
    sublayer.shadowColor = [UIColor blackColor].CGColor;
    sublayer.shadowOpacity = 0.8;
    sublayer.frame = CGRectMake(250, 20, 50, 50);
    
    [self.view.layer addSublayer:sublayer];
    


}
-(void)configureview{
    
    for (int ii=0; ii<=[_shownstuff count]-1; ii++) {
        
    
    UILabel *categoryshared=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 170, 150)];
    categoryshared.textColor=[UIColor blackColor];
    categoryshared.backgroundColor=[UIColor yellowColor];
    categoryshared.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    NSString *initalTextString = [NSString
                                      stringWithFormat:@"I am Sending from my Shoplog Collection: (%@)",
                                      [_shownstuff[ii]valueForKey:@"categoryname"]];

    categoryshared.text=initalTextString;
    categoryshared.numberOfLines=3;
    categoryshared.shadowColor=[UIColor grayColor];
        categoryshared.textAlignment=NSTextAlignmentCenter;
    categoryshared.layer.cornerRadius=10;
    
    
   
    
    CALayer *sublayer = [CALayer layer];
    sublayer.frame = sublayer.bounds;
    sublayer.masksToBounds = YES;
    sublayer.contents = (id) [UIImage imageWithData:[_shownstuff[ii] valueForKey:@"image"]].CGImage;
    sublayer.shadowOffset = CGSizeMake(0, 3);
    sublayer.cornerRadius=20;
    sublayer.shadowRadius = 5.0;
    sublayer.shadowColor = [UIColor blackColor].CGColor;
    sublayer.shadowOpacity = 0.8;
    sublayer.frame = CGRectMake(100, 150, 200, 200);
     
    [self.view addSubview:categoryshared];
    [self.view.layer addSublayer:sublayer];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)handleCancel
{
    id<Shoplogactivityviewcontrollerdelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(ShoplogactivityViewControllerDidCancel:)]) {
        [delegate ShoplogactivityViewControllerDidCancel:self];
        //NSLog(@"Iam Here ");
    }
}
-(void)gotocommunity{

    NSLog(@"I am going to community %@",[_shownstuff[0] valueForKey:@"categoryname"]);
}

@end
