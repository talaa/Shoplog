//
//  SignUpViewController.h
//  ttttt
//
//  Created by Mena Bebawy on 12/3/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlatDatePicker.h"
#import "CountryPicker.h"

@interface SignUpViewController : UIViewController <UITextFieldDelegate,FlatDatePickerDelegate,CountryPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *bDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *emailActivityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *emailTrueImageView;
@property (nonatomic, assign) id<CountryPickerDelegate> delegate;
@property (nonatomic, strong) FlatDatePicker *flatDatePicker;
@property (weak, nonatomic) IBOutlet CountryPicker *countryPicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegment;

@property (nonatomic, copy) NSString *selectedCountryName;
@property (nonatomic, strong) NSString *userGender;
@property (nonatomic) BOOL emailIsTrue;
@property (strong, nonatomic) NSString *password;

- (IBAction)takePhotoPressed:(id)sender;
- (IBAction)gallaryPhotoPressed:(id)sender;
- (IBAction)closePressed:(id)sender;
- (IBAction)bDatePressed:(id)sender;
- (IBAction)countryPressed:(id)sender;
- (IBAction)segmentPressed:(UISegmentedControl *)sender;
- (IBAction)submitPressed:(id)sender;
@end
