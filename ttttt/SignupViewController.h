//
//  SignupViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 9/13/15.
//  Copyright (c) 2015 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "CountryPicker.h"

@interface SignupViewController : UIViewController<UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate,CountryPickerDelegate>
@property (nonatomic,strong)IBOutlet UITextField *username;
@property (nonatomic,strong)IBOutlet UITextField *useremail;
@property (nonatomic,strong)IBOutlet UITextField *country;
@property (nonatomic,strong)IBOutlet UITextField *birthday;
@property (nonatomic,strong)IBOutlet UISegmentedControl *usergender;
@property (nonatomic,strong)IBOutlet UIButton *userimage;
@property (nonatomic,strong)IBOutlet UIButton *imagefromlibrary;
@property (nonatomic,strong)IBOutlet UIButton *imagefromcamera;
@property (nonatomic,strong)IBOutlet UIButton *submit;
@property (nonatomic, retain) CountryPicker *countrypicker;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (nonatomic,strong)NSString *datestring;
@property (nonatomic,strong)UIDatePicker *datepicker;
@end
