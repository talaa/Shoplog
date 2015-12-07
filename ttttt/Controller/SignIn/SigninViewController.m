//
//  SigninViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 10/13/14.
//  Copyright (c) 2014 Tamer Alaa. All rights reserved.
//

#import "SigninViewController.h"
#import "SVProgressHUD.h"
#import <Parse/Parse.h>

@interface SigninViewController ()

@end

@implementation SigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    PFUser *user = [PFUser currentUser];
    if (user){
        self.newuserView.hidden     = YES;
        self.currentUserView.hidden = NO;
        self.nameLabel.text         = user[@"name"];
        self.emailLabel.text        = user.email;
        self.countryLabel.text      = user[@"country"];
        PFFile *imagefile           = user[@"image"];
        if (imagefile != nil){
            self.profileImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagefile.url]]];
        }else{
            self.profileImageView.image = [UIImage imageNamed:@"user"];
        }
        self.profileImageView.layer.cornerRadius    = self.profileImageView.frame.size.width/2;
        self.profileImageView.layer.masksToBounds   = YES;
        self.profileImageView.layer.borderColor     = [UIColor grayColor].CGColor;
        self.profileImageView.layer.borderWidth     = 2.0f;
        
        //button layout
        self.logoutButton.layer.cornerRadius        = 5.0f;
        self.logoutButton.layer.masksToBounds       = YES;
        
        self.editButton.layer.cornerRadius          = 5.0f;
        self.editButton.layer.masksToBounds         = YES;
    }else{
        self.currentUserView.hidden = YES;
        self.newuserView.hidden     = NO;
        
        //Button Layput
        self.signupButton.layer.cornerRadius        = 5.0f;
        self.signupButton.layer.masksToBounds       = YES;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)logoutPressed:(id)sender {
    [PFUser logOut];
    [self viewWillAppear:YES];
}

- (IBAction)signupPressed:(id)sender {
}

- (IBAction)forgotPasswordPressed:(id)sender {
    UIAlertController *forgotAlert = [UIAlertController alertControllerWithTitle:@"Recover Password" message:@"Type your mail." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Reset" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *emailTextField = forgotAlert.textFields.firstObject;
        
        [PFUser requestPasswordResetForEmailInBackground:emailTextField.text block:^(BOOL succeeded, NSError *error){
            if (error){
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }else {
                NSString *message =@"Link to reset your password has been sent to your email";
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Password Reset" message:message preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
                [self viewWillAppear:YES];
            }
        }];

        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    
    [forgotAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Email";
    }];
    
    [forgotAlert addAction:ok];
    [forgotAlert addAction:cancel];
    [self presentViewController:forgotAlert animated:YES completion:nil];
}

- (IBAction)loginPressed:(id)sender {
    UIAlertController *loginAlertcontroller = [UIAlertController alertControllerWithTitle:@"Login Credentias" message:@"Enter your username and password" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    
    UIAlertAction *login = [UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *usernameTextField = loginAlertcontroller.textFields.firstObject;
        UITextField *passwordTextfield = loginAlertcontroller.textFields.lastObject;
        
        [SVProgressHUD showWithStatus:@"Login...."];
        
        [PFUser logInWithUsernameInBackground:usernameTextField.text password:passwordTextfield.text block:^(PFUser *user, NSError *error) {
            if (user) {
                // Do stuff after successful login.
                [SVProgressHUD dismiss];
                [self viewWillAppear:YES];
            } else {
                // The login failed. Check error to see why.
                [SVProgressHUD dismiss];
                UIAlertController *failedAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Username or password is not correct.Try again." preferredStyle:UIAlertControllerStyleAlert];
                [failedAlert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:nil]];
                [self presentViewController:failedAlert animated:YES completion:nil];
            }
        }];
    }];
    
    [loginAlertcontroller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"username";
    }];
    
    [loginAlertcontroller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"password";
        textField.secureTextEntry = YES;
    }];
    
    [loginAlertcontroller addAction:login];
    [loginAlertcontroller addAction:cancel];
    [self presentViewController:loginAlertcontroller animated:YES completion:nil];
}

- (IBAction)editPressed:(id)sender {
}
@end
