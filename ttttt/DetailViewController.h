//
//  DetailViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 10/11/14.
//  Copyright (c) 2014 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "AddProductDetailViewController.h"
@class Shoplog;

@protocol MyPopoverDelegate <NSObject>
-(void)didClickdeleteButton;
@end

@interface DetailViewController : UIViewController<MFMailComposeViewControllerDelegate,MKMapViewDelegate>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Shoplog *currentProduct;
@property (nonatomic,strong)IBOutlet UIImageView *bigimage;
@property (nonatomic,strong)IBOutlet UIVisualEffectView *smallblur;
@property(nonatomic,strong)IBOutlet UILabel *shopnamelabel;
@property (nonatomic,strong)IBOutlet UILabel *dimsizelabel;
@property (nonatomic,strong)IBOutlet UILabel *commentslabel;
@property (nonatomic,strong)IBOutlet MKMapView *storelocation;
@property (nonatomic,strong)IBOutlet UIActivityIndicatorView *activityindicator;
@property (strong, nonatomic) id detailItem;
@property (nonatomic, assign) id<MyPopoverDelegate> delegate;
@property (nonatomic) double longsaved;
@property (nonatomic) double latsaved;
-(IBAction)blurchange:(id)sender;
-(IBAction)goback:(id)sender;
@end
