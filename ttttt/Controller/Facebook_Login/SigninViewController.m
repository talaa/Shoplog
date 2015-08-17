//
//  SigninViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 10/13/14.
//  Copyright (c) 2014 Tamer Alaa. All rights reserved.
//

#import "SigninViewController.h"

@interface SigninViewController ()
@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation SigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.delegate = self;
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_birthday"];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(profileUpdated:) name:FBSDKProfileDidChangeNotification object:nil];
}

-(void)profileUpdated:(NSNotification *) notification{
    NSLog(@"User name: %@",[FBSDKProfile currentProfile].name);
    NSLog(@"User ID: %@",[FBSDKProfile currentProfile].userID);
}

-(void)viewDidAppear:(BOOL)animated{
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        [self showUserData];
        NSLog(@"Welcom");
        [self facebookGraphRequest];
        self.nameLabel.text = [FBSDKProfile currentProfile].name;
        NSLog(@"User ID: %@",[FBSDKProfile currentProfile].userID);
        NSLog(@"User Email: %@",[FBSDKProfile currentProfile].firstName);
        
        //[self performSegueWithIdentifier:@"LoginSuccessSegue" sender:self] ;
    }else{
        [self hiddenUserData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FBSDKLoginButtonDelegete
-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
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
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"picture, email"}] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id res, NSError *error)
     {
         if (!error) {
             NSDictionary *dataDic = [res objectForKey:@"picture"];
             NSDictionary *urlDic = [dataDic objectForKey:@"data"];
             NSString *pictureURL = [urlDic objectForKey:@"url"];
             //NSString *pictureURL = [NSString stringWithFormat:@"%@",[res objectForKey:@"picture"]];
             
             self.emailLabel.text = [res objectForKey:@"email"];
             
             NSData  *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:pictureURL]];
             _profileImageView.image = [UIImage imageWithData:data];
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
