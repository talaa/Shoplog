//
//  SignUpViewController.m
//  ttttt
//
//  Created by Mena Bebawy on 12/3/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "SVProgressHUD.h"
@interface SignUpViewController ()
{
    PFUser *existUser;
    PFUser *user;
}

@end

@implementation SignUpViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    user = [PFUser user];
    self.emailIsTrue = NO;
    
    //Init BirthDate
    self.flatDatePicker = [[FlatDatePicker alloc] initWithParentView:self.view];
    self.flatDatePicker.delegate = self;
    self.flatDatePicker.title = @"Select your birthday";
    self.flatDatePicker.maximumDate = [NSDate date];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.countryPicker.hidden = YES;
    
    //Profile Image Layout
    self.profileImageView.layer.borderColor = [UIColor grayColor].CGColor;
    self.profileImageView.layer.borderWidth = 1.5f;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2;
    self.profileImageView.layer.masksToBounds = YES;
    
    //hide EmailActivity & EmailTrueImage
    self.emailActivityIndicator.hidden  = YES;
    self.emailTrueImageView.hidden      = YES;
    
    //Deticate emailTextfield input life
    [self.emailTextField addTarget:self action:@selector(checkTextField:) forControlEvents:UIControlEventEditingChanged];
    
    //dismiss keyboard &&activityIndicator email when pressed outside it
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(hiddenEmailActivityIndicatorAndDismissKeybad)];
    
    [self.view addGestureRecognizer:tap];
    
    /******************************************************/
    //if there is an exist user thus, it will be edit form//
    //else , it will be a sign up form                    //
    /*****************************************************/
    [self ifThereExistUserFillFormWithData];
}

- (IBAction)takePhotoPressed:(id)sender {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }];
}

- (IBAction)gallaryPhotoPressed:(id)sender {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        //your code
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    
}

- (IBAction)closePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)bDatePressed:(id)sender {
    [self.bDateTextField resignFirstResponder];
    static int count = 0;
    count ++;
    if(count % 2 != 0){
        //show
        [self.flatDatePicker show];
    }else{
        //hide
        [self.flatDatePicker dismiss];
    }
    
}

- (IBAction)countryPressed:(id)sender {
    [self.countryTextField resignFirstResponder];
    static int count = 0;
    count ++;
    if (count % 2 != 0) {
        //show
        self.countryPicker.hidden = NO;
    }else{
        //hidden
        self.countryPicker.hidden = YES;
    }
}

- (IBAction)segmentPressed:(UISegmentedControl *)sender {
    switch (self.genderSegment.selectedSegmentIndex)
    {
        case 0:
            self.userGender = @"Male";
            break;
        case 1:
            self.userGender = @"Female";
            break;
        default:
            self.userGender = @"";
            break;
    }
}

/***********************************************/
#pragma mark - Sumbit Account Methods
/***********************************************/

- (IBAction)submitPressed:(id)sender {
    if (existUser){
        if (self.nameTextFiled.text.length >0 && self.usernameTextField.text.length >0 && self.countryTextField.text.length >0){
            [self passwordAndAddAccountAlertController];
        }else{
            [self submitFailedAlertController];
        }
        
    }else{
        if (self.nameTextFiled.text.length >0 && self.usernameTextField.text.length >0 && self.emailIsTrue == YES && self.countryTextField.text.length >0){
            [self passwordAndAddAccountAlertController];
        }else{
            [self submitFailedAlertController];
        }
        
    }
}

- (void)submitFailedAlertController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Kindly make sure that you has entered manadorty field and a valid E-mail" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)passwordAndAddAccountAlertController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Submit" message:@"Kindly type and confirm your password." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    
    UIAlertAction *submit = [UIAlertAction actionWithTitle:@"Sumbit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Code
        UITextField *password       = alertController.textFields.firstObject;
        UITextField *retypePassword = alertController.textFields.lastObject;
        if ([password.text isEqualToString:retypePassword.text]){
            //Same Password
            //Save New Account
            self.password = password.text;
            [self saveNewAccount];
            
        }else{
            //Different Password
            [self differnetPasswordAlertController];
        }
        
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder      = @"Password";
         textField.secureTextEntry  = YES;
     }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder      = @"Retype Password";
         textField.secureTextEntry  = YES;
     }];
    
    [alertController addAction:submit];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)saveNewAccount {
    [SVProgressHUD showWithStatus:@"Loading...."];
    if (existUser){
        user = existUser;
    }
    user.username = self.usernameTextField.text;
    user.email = self.emailTextField.text;
    user.password = self.password;
    
    user[@"country"] = self.countryTextField.text;
    user[@"name"] = self.nameTextFiled.text;
    
    //Save profile pic image if exist
    if ([self isPicProfileImageViewEmpty] == YES) {
        //don't save because there is no image is uploaded
    }else { //user has uploaded an image then save it
        NSString *userImageName = [self.usernameTextField.text stringByAppendingString:@"_image.png"];
        NSData *imageData = UIImagePNGRepresentation(self.profileImageView.image);
        PFFile *imageFile = [PFFile fileWithName:userImageName data:imageData];
        user[@"image"] = imageFile;
    }
    
    //check Gender
    if (self.userGender.length >0){
        user[@"gender"] = self.userGender;
    }
    
    //check bDateTextFiled
    if (self.bDateTextField.text.length>0){
        user[@"birthDate"] = self.bDateTextField.text;
    }
    
    //In case of there is an exist user --> thus, it is an updating
    if (existUser){
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // Hooray! Let them use the app now.
                //turn to previous page
                [self resetPropretriesAfterSave];
                [self getBackToWelcomeView];
                
            }
            // Thus , this is saving a new user
            else {
                [SVProgressHUD dealloc];
                NSString *errorString = [error userInfo][@"error"];
                // Show the errorString somewhere and let the user try again.
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:errorString preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
        }];
    }else{
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // Hooray! Let them use the app now.
                //turn to previous page
                [self resetPropretriesAfterSave];
                [self getBackToWelcomeView];
                
            } else {
                [SVProgressHUD dealloc];
                NSString *errorString = [error userInfo][@"error"];
                // Show the errorString somewhere and let the user try again.
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:errorString preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
        }];
    }
    
}

- (void)differnetPasswordAlertController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Passwords are not the same.Retype same password please!." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)getBackToWelcomeView {
    [SVProgressHUD showSuccessWithStatus:@"Your count has been added successfully.Welcome on Shoplog land."];
    [SVProgressHUD dismissWithDelay:2];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)resetPropretriesAfterSave{
    self.usernameTextField.text     = @"";
    self.countryTextField.text      = @"";
    self.bDateTextField.text        = @"";
    self.emailTextField.text        = @"";
    self.nameTextFiled.text         = @"";
    
    self.password                   = @"";
    self.emailIsTrue                = NO;
    
}

/*****************************************/
#pragma mark - FlatDatePicker Delegate
/****************************************/

- (void)flatDatePicker:(FlatDatePicker*)datePicker dateDidChange:(NSDate*)date {
}

- (void)flatDatePicker:(FlatDatePicker*)datePicker didCancel:(UIButton*)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FlatDataPicker" message:@"Did cancelled" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)flatDatePicker:(FlatDatePicker*)datePicker didValid:(UIButton*)sender date:(NSDate*)date {
    UIAlertController *alertController;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *value = [dateFormatter stringFromDate:date];
    
    self.bDateTextField.text = value;
    NSString *message = [NSString stringWithFormat:@"Valid date : %@", value];
    alertController = [UIAlertController alertControllerWithTitle:@"Birth Date" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - CountryPickerDekegate

- (void)setSelectedCountryName:(NSString *)countryName animated:(BOOL)animated{
    self.countryTextField.text  = countryName;
}

- (void)countryPicker:(__unused CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{
    self.countryTextField.text = name;
}


#pragma mark - UIImagePickerControllerDelegete

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation((chosenImage),1.0)];
    self.profileImageView.image = [UIImage imageWithData:imageData];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - TextField real time check

-(void)checkTextField:(id)sender {
    [self showEmailActivityIndicatorAndHideEmailImage];
    if ([self validEmail:self.emailTextField.text] == YES){
        [self hideEmailActivityIndicatorShowEmailImage];
        self.emailIsTrue = YES;
    }
}

- (BOOL) validEmail:(NSString*) emailString {
    if([emailString length]==0){
        return NO;
    }
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    //NSLog(@"%lu", (unsigned long)regExMatches);
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - EmailActivityIndicator and ImageTrue Behaviour

- (void)hideEmailActivityIndicatorShowEmailImage {
    [self.emailActivityIndicator stopAnimating];
    self.emailActivityIndicator.hidden = YES;
    self.emailTrueImageView.hidden = NO;
}

- (void)hideEmailActivityIndicatorHideEmailImage {
    [self.emailActivityIndicator stopAnimating];
    self.emailActivityIndicator.hidden = YES;
    self.emailTrueImageView.hidden = YES;
}

- (void)showEmailActivityIndicatorAndHideEmailImage {
    self.emailTrueImageView.hidden = YES;
    self.emailActivityIndicator.hidden = NO;
    [self.emailActivityIndicator startAnimating];
    
}


#pragma mark - HideTextFieldKeyBoard
- (void)hiddenEmailActivityIndicatorAndDismissKeybad{
    [self.usernameTextField resignFirstResponder];
    [self.nameTextFiled resignFirstResponder];
    [self.bDateTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    self.emailActivityIndicator.hidden = YES;
}

/********************************************/
#pragma mark - Is Pic Profile Is The Default or User Enter His/Her Pic
- (bool)isPicProfileImageViewEmpty {
    //Check if picProfileImageView empty
    UIImage *picture;
    picture = [UIImage imageNamed:@"user"];
    
    if ([self.profileImageView.image isEqual:picture]){
        //no image set
        return YES;
    }
    else{
        return NO;
    }
}

/***********************************************/
// Chek if there is an exist user               //
/**********************************************/

- (void)ifThereExistUserFillFormWithData{
    existUser = [PFUser currentUser];
    if (existUser){
        self.nameTextFiled.text = existUser[@"name"];
        self.emailTextField.text = existUser.email;
        self.usernameTextField.text = existUser.username;
        if (existUser[@"gender"]){
            if ([existUser[@"gender"] isEqualToString:@"Male"]){
                self.genderSegment.selectedSegmentIndex = 0;
            }else
                self.genderSegment.selectedSegmentIndex = 1;
        }
        if (existUser[@"birthDate"]){
            self.bDateTextField.text = existUser[@"birthDate"];
        }
        self.countryTextField.text = existUser[@"country"];
        if(existUser[@"image"]){
            PFFile *imagefile = existUser[@"image"];
            self.profileImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagefile.url]]];
        }else{
            self.profileImageView.image = [UIImage imageNamed:@"user"];
        }
    }
}
@end
