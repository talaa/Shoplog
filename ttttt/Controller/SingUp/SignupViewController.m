//
//  SignupViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 9/13/15.
//  Copyright (c) 2015 Tamer Alaa. All rights reserved.
//

#import "SignupViewController.h"
@class CountryPicker;

@implementation SignupViewController
@synthesize imagePicker,popoverController,datestring,datepicker,countrypicker,country;
@synthesize useremail,usergender,username,userimage,imagefromcamera,imagefromlibrary,submit,birthday;

-(void)viewDidLoad{
    [userimage.layer setCornerRadius:25.0f];
    [userimage.layer setMasksToBounds:YES];
    datepicker = [[UIDatePicker alloc] init];
    countrypicker=[[CountryPicker alloc]init];
    //NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    //picker1.dataSource = self;
    countrypicker.delegate = self;
    countrypicker.showsSelectionIndicator=YES;
    [datepicker setDatePickerMode:UIDatePickerModeDate];
    self.birthday.inputView=datepicker;
    self.country.inputView=countrypicker;
    
    [datepicker addTarget:self
     
                   action:@selector(LabelChange:)
     
         forControlEvents:UIControlEventValueChanged];
    
    
    
}
- (void)LabelChange:(id)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    df.dateStyle = NSDateFormatterMediumStyle;
    
    datestring=[NSString stringWithFormat:@"%@",[df stringFromDate:datepicker.date]];
    
    self.birthday.text = datestring;
    
}
-(IBAction)submitandsave:(id)sender{
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    [userdefault setObject:username.text forKey:@"username"];
    [userdefault setObject:useremail.text forKey:@"useremail"];
    [userdefault setObject:birthday.text forKey:@"userbirthday"];
    [userdefault setObject:country.text forKey:@"usercountry"];
    
    NSString *dateString = birthday.text ;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    /*
    PFObject *Users = [PFObject objectWithClassName:@"Users"];
    Users[@"User_Name"] = username.text;
    Users[@"email"] = useremail.text;
    Users[@"Birthday"]=dateFromString;
    Users[@"User_Location"]=country.text;
    [Users saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"we have saved a new User ");
            [self performSegueWithIdentifier:@"gotoprofile" sender:self];

        } else {
            // There was a problem, check error.description
        }
    }];
    */
    
    if ([PFUser new]) {
    PFUser *user = [PFUser user];
        [user setUsername:username.text];
        [user setPassword:@""];
        [user setEmail:useremail.text];
        
        [user setObject:datepicker.date forKey:@"Birthday"];
        [user setObject:country.text forKey:@"User_Location"];
        [user setObject:[usergender titleForSegmentAtIndex:[usergender selectedSegmentIndex]]forKey:@"User_Gender"];
        NSData *imageData = UIImagePNGRepresentation(userimage.imageView.image);
        PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
        [user setObject:imageFile forKey:@"Avatar"];
        //PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
        //userPhoto[@"imageName"] = @"My trip to Hawaii!";
        //userPhoto[@"imageFile"] = imageFile;
        //[userPhoto saveInBackground];
        
        /*
    user.username=@"username";
    user.password = @"";
    user.email = useremail.text;
    user[@"User_Name"] = username.text;
    user[@"Birthday"]=dateFromString;
    user[@"User_Location"]=country.text;
         */
     NSLog(@"the user name is %@",user.username);
    
    // other fields can be set just like with PFObject
    
        
        
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            NSLog(@"we have saved a new User ");
            [self performSegueWithIdentifier:@"gotoprofile" sender:self];
        } else {   NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            NSLog(@"%@",errorString);
        }
    }];
        
    }
    

}
-(IBAction)Cancel:(id)sender{

[self performSegueWithIdentifier:@"gotoprofile" sender:self];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)back:(id)sender{
    [sender resignFirstResponder];
    
}
-(IBAction)countrychanged:(id)sender{

self.country.text=countrypicker.selectedCountryName;

}
- (void)setSelectedCountryName:(NSString *)countryName animated:(BOOL)animated{
    self.country.text=countryName;
    //NSLog(@"%@",countryName);

}
- (void)setSelectedLocale:(NSLocale *)locale animated:(BOOL)animated{



}

- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code{

    
    self.country.text=picker.selectedCountryName;
//self.country.text=name;
    //NSLog(@"%@",name);

}

-(IBAction)userimageclicked:(id)sender{
    if (imagefromlibrary.hidden) {
        imagefromlibrary.hidden=NO;
        imagefromcamera.hidden=NO;
    }else{
        imagefromlibrary.hidden=YES;
        imagefromcamera.hidden=YES;
    }

}

- (IBAction)imageFromAlbum:(id)sender
{
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if ([self.popoverController isPopoverVisible]) {
            [self.popoverController dismissPopoverAnimated:YES];
        } else {
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
            [popover presentPopoverFromRect:self.userimage.bounds inView:self.userimage permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            self.popoverController=popover;
        }
    } else {
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
    
    
    // [self presentViewController:imagePicker animated:YES completion:nil];
}
//  Take an image with camera
- (IBAction)imagefromCamera:(id)sender {
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    [popoverController dismissPopoverAnimated:YES];
    [userimage setImage:image forState:UIControlStateNormal];
    imagefromlibrary.hidden=YES;
    imagefromcamera.hidden=YES;
}

//  On cancel, only dismiss the picker controller
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}

@end
