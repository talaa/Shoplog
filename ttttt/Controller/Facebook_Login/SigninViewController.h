//
//  SigninViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 10/13/14.
//  Copyright (c) 2014 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKProfilePictureView.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Flurry.h"
#import "MainTabBarController.h"
#define Ksingedinalready @"signedalready"


@interface SigninViewController : UIViewController <FBSDKLoginButtonDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@end
