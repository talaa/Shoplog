//
//  SignUpViewController.m
//  ttttt
//
//  Created by Mena Bebawy on 12/3/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import "SignUpViewController.h"

@implementation SignUpViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
            self.userGender = @"Female";
            break; 
    }
}

- (IBAction)submitPressed:(id)sender {
}

#pragma mark - FlatDatePicker Delegate

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
    if (date > [NSDate date]){
        NSString *message = [NSString stringWithFormat:@"Incorrect Birthdate : %@", value];
        alertController = [UIAlertController alertControllerWithTitle:@"Incorrect Birth Date" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
    }else {
        self.bDateTextField.text = value;
        NSString *message = [NSString stringWithFormat:@"Did valid date : %@", value];
        alertController = [UIAlertController alertControllerWithTitle:@"Birth Date" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
    }
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

@end
