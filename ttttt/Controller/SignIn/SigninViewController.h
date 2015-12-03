//
//  SigninViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 10/13/14.
//  Copyright (c) 2014 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
//#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>
#import "Flurry.h"
#define Ksingedinalready @"signedalready"


@interface SigninViewController : UIViewController
@property(nonatomic,strong)IBOutlet UIImageView *logoimage;
@property (nonatomic,strong)IBOutlet UIImageView *userimage;
@property (nonatomic,strong)IBOutlet UILabel *welcomenote;
@property (nonatomic,strong)IBOutlet UIButton *logintbutton;
@property (nonatomic,strong)IBOutlet UIButton *logoutbutton;
@property (nonatomic,strong)IBOutlet UIButton *Signupbutton;
@property (nonatomic,strong)IBOutlet UIImageView *wishlistimage;
@property (nonatomic,strong)IBOutlet UIImageView *shopbagimage;
@property (nonatomic,strong)IBOutlet UILabel *wishlistcount;
@property (nonatomic,strong)IBOutlet UILabel *shoplogerstatus;

@property (nonatomic)NSString *facebookID ;
@property (nonatomic)NSString *username ;
@property (nonatomic)NSString *userlocation ;
@property (nonatomic)NSString *usergender ;
@property (nonatomic)NSString *userbirthday;
@property (nonatomic)NSString *userrelationship ;
@property (nonatomic)NSString *useremail ;
- (IBAction)logoutButtonAction:(id)sender ;
@end