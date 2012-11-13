//
//  setlocationViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 11/6/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//
#define METERS_PER_MILE 1609.344
#import "setlocationViewController.h"
#import "MyAnotation.h"
#import "AddProductDetailViewController.h"
@interface setlocationViewController ()

@end

@implementation setlocationViewController
@synthesize setlocationMap,shoplocationlong,shoplocationlat,lgpr,longano,latano,managedObjectcontext;
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
    MKCoordinateRegion mapRegion;
    //mapRegion.center=CLLocationCoordinate2DMake(50, -100);
    mapRegion.center = setlocationMap.userLocation.coordinate;
    
    mapRegion.span.latitudeDelta = 2;
    mapRegion.span.longitudeDelta = 2;
    [setlocationMap setRegion:mapRegion animated: YES];

    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveShoplocation:(id)sender {
    //Save the Coordinates to the system
    
    AddProductDetailViewController *hhhh=[[AddProductDetailViewController alloc]init];
    hhhh.longsaved=longano;
    hhhh.latsaved=latano;
    //hhhh.currentProduct.shop.longcoordinate=annot.coordinate.longitude;
    //NSLog(@"This Thing will not Work %f",hhhh.currentProduct.shop.longcoordinate);
}
- (IBAction)lgpraction:(id)sender {
    
    if (lgpr.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [lgpr locationInView:self.setlocationMap];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.setlocationMap convertPoint:touchPoint toCoordinateFromView:self.setlocationMap];
    
    MyAnotation *annot = [[MyAnotation alloc] init];
    annot.coordinate = touchMapCoordinate;
    [self.setlocationMap addAnnotation:annot];
    longano=annot.coordinate.longitude;
    latano=annot.coordinate.latitude;
    //Save the Coordinates to the system
    
    //AddProductDetailViewController *hhhh=[[AddProductDetailViewController alloc]init];
    //hhhh.currentProduct.shop.latcoordinate=annot.coordinate.latitude;
    //hhhh.currentProduct.shop.longcoordinate=annot.coordinate.longitude;
    //NSLog(@"This Thing will not Work %f",hhhh.currentProduct.shop.longcoordinate);
}
@end
