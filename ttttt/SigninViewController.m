//
//  SigninViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 10/13/14.
//  Copyright (c) 2014 Tamer Alaa. All rights reserved.
//

#import "SigninViewController.h"

@interface SigninViewController ()

@end

@implementation SigninViewController
@synthesize logoimage,userimage,logoutbutton,logintbutton,welcomenote,facebookID,userbirthday,usergender,userlocation,username,userrelationship,useremail;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loaddata];
    [welcomenote.layer setCornerRadius:30.f];
    [welcomenote.layer setMasksToBounds:YES];
    
    [userimage.layer setCornerRadius:30.0f];
    [userimage.layer setMasksToBounds:YES];
    
    [logoimage.layer setCornerRadius:30.0f];
    [logoimage.layer setMasksToBounds:YES];


    logoutbutton.hidden=YES;
    welcomenote.hidden=YES;
     NSUserDefaults *userdefaults =[NSUserDefaults standardUserDefaults];
    if ([userdefaults boolForKey: Ksingedinalready]) {
        //[self userisalreadysignedin];
        UIAlertView *confirmation=[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Please Login for confirmation" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [confirmation show];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Signin:(id)sender{
    NSArray *permissions=@[@"public_profile", @"email", @"user_friends"];
    [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
            UIAlertView *Connectioncheck=[[UIAlertView alloc]initWithTitle:@"OOOPS" message:@"Something Happened while Connecting to Facebook" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [Connectioncheck show];
        } else {
            if (user.isNew) {
                //[self loaddata];
            NSLog(@"User signed up and logged in through Facebook!");
            //[self performSegueWithIdentifier:@"shoplogers" sender:self];
                NSDictionary *flurrydicttionary=[[NSDictionary alloc]initWithObjectsAndKeys:usergender,@"Gender", nil];
                [Flurry logEvent:@"Gender" withParameters:flurrydicttionary timed:YES];
            } else {
                NSLog(@"User already logged in through Facebook!");
            //[self performSegueWithIdentifier:@"shoplogers" sender:self];
                [self userisalreadysignedin];
                
            }
            user[@"FacebookID"]=facebookID;
            user[@"User_Name"]=username;
            user[@"User_Location"]=userlocation;
            user[@"User_Gender"]=usergender;
            user[@"email"]=useremail;
            user[@"Loyalty_Points"]=0;
            user[@"Wish_Lists"]=nil;
            //[user setObject:facebookID forKey:@"FacebookID"];
            //[user setObject:username forKey:@"User_Name"];
            //[user setObject:userlocation forKey:@"User_Location"];
            //[user setObject:usergender forKey:@"User_Gender"];
            //[currentUser setObject:userrelationship forKey:@"User_relationship"];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    NSLog(@"I have finished saving the user data in parse %@",user.objectId);
                    NSUserDefaults *userdefaults =[NSUserDefaults standardUserDefaults];
                    [userdefaults setBool:YES forKey:Ksingedinalready];
                    [self userisalreadysignedin];
                    
                    
                }
                else{
                    NSLog(@"The saving error is %@",error);
                    
                }
            }];

        }
    }];
    

}

-(void)userisalreadysignedin{
    logintbutton.hidden=YES;
    welcomenote.hidden=NO;
    welcomenote.text=[NSString stringWithFormat:@"Welcome %@",username];
    
    logoutbutton.hidden=NO;
    NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
    
    // Run network request asynchronously
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         if (connectionError == nil && data != nil) {
             // Set the image in the header imageView
             userimage.image = [UIImage imageWithData:data];
         }
     }];


}

-(void)loaddata{
    

    FBRequest *request = [FBRequest requestForMe];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
           facebookID = userData[@"id"];
            username = userData[@"name"];
            userlocation = userData[@"location"][@"name"];
            usergender = userData[@"gender"];
            userbirthday = userData[@"birthday"];
            userrelationship = userData[@"relationship_status"];
            useremail=userData[@"email"];
            
            
            NSLog(@"I have finished retreiving the user data ");
            // Now add the data to the UI elements
            // ...
                       
        }
    }];
    

}
- (IBAction)logoutButtonAction:(id)sender  {
    [PFUser logOut]; // Log out
    logintbutton.hidden=NO;
    welcomenote.hidden=YES;
    logoutbutton.hidden=YES;
    userimage.image=nil;
    // Return to Login view controller
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
