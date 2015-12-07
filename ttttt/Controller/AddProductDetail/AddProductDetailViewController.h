//
//  AddProductDetailViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 9/25/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "MyAnotation.h"
#import <Parse/Parse.h>

#import "Shoplog.h"
#import "Shop.h"
#define KRated @"isalreadyrated"
@class Shoplog;
@class Shop;
@protocol addproductdetailviewcontrollerdelegate;
@interface AddProductDetailViewController : UITableViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UITextFieldDelegate,MKMapViewDelegate,UITextViewDelegate, UIAlertViewDelegate,CLLocationManagerDelegate>
{

    //CLLocationManager *lm;
    MyAnotation *annotation;

}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) Shoplog *currentProduct;
@property (strong,nonatomic)Shop *currentshop;
@property (nonatomic ) BOOL edit_add;
@property (nonatomic ) BOOL newcatalogue;
@property (nonatomic ) BOOL Qrcodecatalogue;
@property (strong, nonatomic) IBOutlet UITextField *PriceField;
@property (strong, nonatomic) IBOutlet UITextField *ShopField;
@property (strong, nonatomic) IBOutlet UITextField *cataloguenamefield;
@property (strong, nonatomic) IBOutlet UIImageView *imageField;
@property (strong, nonatomic) IBOutlet UITextField *DimensionsField;
@property (strong,nonatomic) IBOutlet UIView *gradientview;
@property (weak, nonatomic) IBOutlet UITextView *commentsView;
@property (weak, nonatomic) IBOutlet MKMapView *Maplocation;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;


@property (weak, nonatomic) IBOutlet UISlider *ratingslider;
@property (weak, nonatomic) IBOutlet UITextField *PhoneField;
@property (weak, nonatomic) IBOutlet UITextField *EmailField;
@property (weak, nonatomic) IBOutlet UITextField *WebsiteField;

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *Testnavigation;
@property (nonatomic,weak) id <addproductdetailviewcontrollerdelegate> delegate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Saveeditbutton;
@property (weak, nonatomic) IBOutlet UIButton *GetcurrentLocation;
@property (nonatomic) BOOL keyboardisShown;
@property (nonatomic) double longsaved;
@property (nonatomic) double latsaved;
@property (weak, nonatomic) IBOutlet UITextField *LongTextfield;
@property (weak, nonatomic) IBOutlet UITextField *LatTextField;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *Lgpressgesture;
- (IBAction)Lgpraction:(id)sender;



- (IBAction)GetcurrentLocation1:(id)sender;


@end
