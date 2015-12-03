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
}


- (IBAction)takePhotoPressed:(id)sender {
}

- (IBAction)gallaryPhotoPressed:(id)sender {
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

- (IBAction)segmentPressed:(id)sender {
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

@end
