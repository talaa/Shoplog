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
#import "Flurry.h"
#define Ksingedinalready @"signedalready"


@interface SigninViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *currentUserView;
@property (weak, nonatomic) IBOutlet UIView *newuserView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

- (IBAction)loginPressed:(id)sender;
- (IBAction)editPressed:(id)sender;
- (IBAction)logoutPressed:(id)sender;
- (IBAction)signupPressed:(id)sender;
- (IBAction)forgotPasswordPressed:(id)sender;
@end
