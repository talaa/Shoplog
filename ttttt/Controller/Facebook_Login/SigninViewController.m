//
//  SigninViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 10/13/14.
//  Copyright (c) 2014 Tamer Alaa. All rights reserved.
//

#import "SigninViewController.h"

@interface SigninViewController ()
{
    NSArray *permissionsArray;
}
@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation SigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    permissionsArray = @[ @"user_about_me",@"email"];//, @"user_relationships", @"user_birthday", @"user_location"];
    [self facebookLogin];
}

-(void)profileUpdated:(NSNotification *) notification{
    NSLog(@"User name: %@",[FBSDKProfile currentProfile].name);
    NSLog(@"User ID: %@",[FBSDKProfile currentProfile].userID);
}

-(void)viewDidAppear:(BOOL)animated{
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        [self showUserData];
        [self facebookGraphRequest];
        self.nameLabel.text = [FBSDKProfile currentProfile].name;
        NSLog(@"User ID: %@",[FBSDKProfile currentProfile].userID);
        NSLog(@"User Email: %@",[FBSDKProfile currentProfile].firstName);
        //[self performSegueWithIdentifier:@"LoginSuccessSegue" sender:self] ;
    }else{
        [self hiddenUserData];
    }
}

-(void)facebookLogin{
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.delegate = self;
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    loginButton.readPermissions = permissionsArray;
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(profileUpdated:) name:FBSDKProfileDidChangeNotification object:nil];
}

- (void)parseSaving{
    // Login PFUser using Facebook
//    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
//        if (!user) {
//            NSLog(@"Uh oh. The user cancelled the Facebook login.");
//        } else if (user.isNew) {
//            NSLog(@"User signed up and logged in through Facebook!");
//        } else {
//            NSLog(@"User logged in through Facebook!");
//        }
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FBSDKLoginButtonDelegete
-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    [self parseSaving];
    [self showUserData];
    [self facebookGraphRequest];
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/permissions"
                                       parameters:nil
                                       HTTPMethod:@"DELETE"]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         // ...
         NSLog(@"Logout Done");
         [self hiddenUserData];
     }];
}

-(void)hiddenUserData{
    self.profileImageView.hidden = YES;
    self.nameLabel.hidden = YES;
    self.emailLabel.hidden = YES;
}

- (void)showUserData{
    self.profileImageView.hidden = NO;
    self.nameLabel.hidden = NO;
    self.emailLabel.hidden = NO;
}

- (void)facebookGraphRequest{
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"picture, email, age_range,locale,gender"}] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id res, NSError *error)
     {
         if (!error) {
             NSDictionary *dataDic = [res objectForKey:@"picture"];
             NSDictionary *urlDic = [dataDic objectForKey:@"data"];
             NSString *pictureURL = [urlDic objectForKey:@"url"];
             
             self.nameLabel.text = [FBSDKProfile currentProfile].name;
             self.emailLabel.text = [res objectForKey:@"email"];
             
             NSData  *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:pictureURL]];
             _profileImageView.image = [UIImage imageWithData:data];
             _profileImageView.layer.borderWidth = 1.0f;
             _profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
             if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                 _profileImageView.layer.cornerRadius = 100;
             }else{
                 _profileImageView.layer.cornerRadius = 50;
             }
             _profileImageView.layer.masksToBounds = YES;
             
         }
         else
         {
             NSLog(@"%@", [error localizedDescription]);
         }}];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"LoginSuccessSegue"]){
        MainTabBarController *main = segue.destinationViewController;
    }
}

@end
