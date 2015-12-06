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
@property (nonatomic,strong)IBOutlet UIButton *Signupbutton;
@property (weak, nonatomic) IBOutlet UIView *currentUserView;
@property (weak, nonatomic) IBOutlet UIView *newUserView;

@end
