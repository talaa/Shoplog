//
//  DetailViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 10/11/14.
//  Copyright (c) 2014 Tamer Alaa. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"

@interface DetailViewController ()
@property(nonatomic)BOOL showmax;
@end

@implementation DetailViewController
@synthesize bigimage,delegate,smallblur,showmax,shopnamelabel,dimsizelabel,commentslabel,storelocation,longsaved,latsaved;
@synthesize activityindicator,managedObjectContext,currentProduct;
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    /*
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
     */
}
- (void)viewDidLoad {
    [super viewDidLoad];
    showmax=NO;
    [self configureView];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)blurchange:(id)sender{
    //[smallblur removeFromSuperview];
    if (showmax) {
        [smallblur setFrame:CGRectMake(0, 510,
                                       self.view.frame.size.width, self.view.frame.size.height)];
        //smallblur.frame=CGRectMake(0, 351,self.view.frame.size.width, self.view.frame.size.height);
        showmax=NO;

    }else{
        [smallblur setFrame:CGRectMake(0, 10,
                                       self.view.frame.size.width, self.view.frame.size.height)];
        //smallblur.frame=CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height);
        showmax=YES;

    }
    //[bigimage addSubview:smallblur];


}
- (void)configureView
{
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Tag2.png"]];
    // Update the user interface for the detail item.
    //Shoplog *shoploginfo=self.detailItem;
   activityindicator.hidden=YES;
    activityindicator.hidesWhenStopped=YES;
    self.currentProduct=self.detailItem;
    Shop *shopdetails=[self.detailItem shop];
    if (self.detailItem) {
        [bigimage setImage:[UIImage imageWithData:[self.detailItem valueForKey:@"image"]]];
        //self.bigimage.image=[UIImage imageNamed:[self.detailItem valueForKey:@"image"]];
        self.dimsizelabel.text=[self.detailItem valueForKey:@"dim_size"];
        self.shopnamelabel.text=shopdetails.shopname;
        NSLog(@"The parse id is %@",[self.detailItem valueForKey:@"parseid"]);
        self.commentslabel.text=[self.detailItem valueForKey:@"comments"];
        
        self.dimsizelabel.backgroundColor=[UIColor whiteColor];
        [self.dimsizelabel.layer setCornerRadius:5];
        [self.dimsizelabel.layer setMasksToBounds:YES];
        
        self.shopnamelabel.backgroundColor=[UIColor whiteColor];
        [self.shopnamelabel.layer setCornerRadius:5];
        [self.shopnamelabel.layer setMasksToBounds:YES];
        
        self.commentslabel.backgroundColor=[UIColor orangeColor];
        [self.commentslabel.layer setCornerRadius:10];
        [self.commentslabel.layer setMasksToBounds:YES];
        [self step1locationupdate:shopdetails.longcoordinate latitude:shopdetails.latcoordinate];
        //NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //[formatter setDateFormat:@"MM-dd HH:mm"];
        
        //Optionally for time zone converstions
        //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
        
        //NSString *stringFromDate = [formatter stringFromDate:[self.detailItem valueForKey:@"date"]];
        
        //self.datelabel.text=stringFromDate;
        //Adding the blur effect
        //UIVisualEffect *blurEffect;
        //blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        
        //smallblur = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        
       //smallblur.frame = bigimage.bounds;
        /*
        if (!showmax) {
            smallblur.frame=CGRectMake(0, 510,
                                       self.view.frame.size.width, self.view.frame.size.height); ;
        }
         */
        //[self.view addSubview:smallblur];
    }
}
-(IBAction)deleteitem:(id)sender{
    
    
    NSManagedObject *managedobject=self.detailItem;
    NSManagedObjectContext *context=[managedobject managedObjectContext];
    [context deleteObject:managedobject];
    NSError *error;
    if (![context save:&error]) {
        // Handle the error.
        
    }
    
    
    [self.delegate didClickdeleteButton];
    [self dismissViewControllerAnimated:YES completion:nil];
    }
-(IBAction)Edit:(id)sender{

    [self performSegueWithIdentifier:@"EditDetail1" sender:self];
}
-(IBAction)goback:(id)sender{


[self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"EditDetail1"]) {
        //  Get a reference to our detail view
        AddProductDetailViewController  *editview = (AddProductDetailViewController *)[segue destinationViewController];
        
        [editview setCurrentProduct:self.detailItem];
        
    }
    
    if ([[segue identifier] isEqualToString:@"BrowseUrl"]) {
        WebViewController  *brurl = (WebViewController *)[segue destinationViewController];
        NSLog(@"the Url is %@",[self.detailItem valueForKey:@"websiteurl"]);
        NSString *theurl=[self.detailItem valueForKey:@"websiteurl"];
        
        
        if (!theurl) {
            UIAlertView *nourlalert=[[UIAlertView alloc]initWithTitle:@"NO Website" message:NSLocalizedString(@"NOWEBSITE", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [nourlalert show];
        }else{
            
            [brurl setNewbrowseurl:[@"http://" stringByAppendingString:[self.detailItem valueForKey:@"websiteurl"]]];

            //[brurl setBrowseuuurl:[[NSURL alloc]initWithString:[@"http://" stringByAppendingString:[self.detailItem valueForKey:@"websiteurl"]]]];
            [brurl setThetitle:[self.detailItem valueForKey:@"categoryname"]];
            //[brurl setTitle:[self.detailItem valueForKey:@"categoryname"]];
            
        }
        
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"The button Pressed is %ld",(long)buttonIndex);
    if (buttonIndex==1) {
        
        
        //Check if Shopdetails Are available;
        NSLog(@"Checking shopdetails");
        [self sendtoshoplog];
    }
    
}
-(void)sendtoshoplog{
    PFUser *currentuser=[PFUser currentUser];
    PFObject *shoplogitem = [PFObject objectWithClassName:@"Request_to_Shoplog"];
    PFFile *file = [PFFile fileWithName:@"product_photo" data:[self.detailItem valueForKey:@"image"]];
    Shop *shopdetails=[self.detailItem shop];
    
    PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:[shopdetails latcoordinate] longitude:[shopdetails longcoordinate]];
    if (!currentuser) {
        // show the signup or login screen
        
    } else {
        
        NSString *parseid1=[self.detailItem valueForKey:@"Parseid"];
        if (!parseid1) {
            activityindicator.hidden=NO;
            [activityindicator startAnimating];
            
            
            shoplogitem[@"Product_categroyname"] = [self.detailItem valueForKey:@"categoryname"];
            shoplogitem[@"Product_price"] = [self.detailItem valueForKey:@"price"];
            shoplogitem[@"Product_rating"] = [self.detailItem valueForKey:@"rating"];
            shoplogitem[@"Product_Dim_Size"] = [self.detailItem valueForKey:@"dim_size"];
            shoplogitem[@"Store_shoplocation"] = point;
            shoplogitem[@"Store_shopname"] = [shopdetails shopname];
            shoplogitem[@"Store_website"] = [self.detailItem valueForKey:@"websiteurl"];
            shoplogitem[@"Store_phone"] = [self.detailItem valueForKey:@"phone"];
            shoplogitem[@"Store_email"] = [self.detailItem valueForKey:@"email"];
            shoplogitem[@"Products_comments"] = [self.detailItem valueForKey:@"comments"];
            shoplogitem[@"Product_photo"]=file;
            shoplogitem[@"User_email"]=currentuser.email;
            shoplogitem[@"User_FacebookID"]=[currentuser objectForKey:@"FacebookID"];
            shoplogitem[@"User_Name"]=[currentuser objectForKey: @"User_Name"];
            shoplogitem[@"User_Location"]=[currentuser objectForKey: @"User_Location"];
            [shoplogitem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"item saved properly %@",self.currentProduct);
                    [self.currentProduct setParseid:shoplogitem.objectId];
                    self.managedObjectContext=self.currentProduct.managedObjectContext;
                    //  Commit item to core data
                    NSError *error;
                    if (![self.managedObjectContext save:&error])
                        NSLog(@"Unresolved error %@, %@, %@", error, [error userInfo],[error localizedDescription]);
                    else{
                        //NSLog(@"The New Item is :%@",self.currentProduct);
                        NSLog(@"The New shop Item is %@ ",self.currentProduct);
                        /*
                         NSArray *permissions=@[@"public_profile", @"email", @"user_friends",@"publish_actions"];
                         [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
                         if (!user) {
                         NSLog(@"Uh oh. The user cancelled the Facebook login.");
                         } else if (user.isNew) {
                         NSLog(@"User signed up and logged in through Facebook!");
                         } else {
                         NSLog(@"User logged in through Facebook!");
                         }
                         }];
                         */
                    }
                    
                    [activityindicator stopAnimating];
                }
            }];
            
            
        }else{
            
            
            
            PFQuery *noduplicatequery=[PFQuery queryWithClassName:@"Request_to_Shoplog"];
            [noduplicatequery getObjectInBackgroundWithId:parseid1 block:^(PFObject *existingobject, NSError *error) {
                // Do something with the returned PFObject in the gameScore variable.
                if (existingobject) {
                    NSLog(@"%@", existingobject);
                    UIAlertView *itemexists=[[UIAlertView alloc]initWithTitle:@"Item Already Exists" message:@"Will Update the Existing Item in our Database" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [itemexists show];
                    activityindicator.hidden=NO;
                    [activityindicator startAnimating];
                    
                    
                    existingobject[@"Product_categroyname"] = [self.detailItem valueForKey:@"categoryname"];
                    existingobject[@"Product_price"] = [self.detailItem valueForKey:@"price"];
                    existingobject[@"Product_rating"] = [self.detailItem valueForKey:@"rating"];
                    existingobject[@"Product_Dim_Size"] = [self.detailItem valueForKey:@"dim_size"];
                    existingobject[@"Store_shoplocation"] = point;
                    existingobject[@"Store_shopname"] = [shopdetails shopname];
                    existingobject[@"Store_website"] = [self.detailItem valueForKey:@"websiteurl"];
                    existingobject[@"Store_phone"] = [self.detailItem valueForKey:@"phone"];
                    existingobject[@"Store_email"] = [self.detailItem valueForKey:@"email"];
                    existingobject[@"Product_comments"] = [self.detailItem valueForKey:@"comments"];
                    existingobject[@"Product_productphoto"]=file;
                    existingobject[@"User_email"]=currentuser.email;
                    existingobject[@"User_FacebookID"]=[currentuser objectForKey:@"FacebookID"];
                    existingobject[@"User_Name"]=[currentuser objectForKey: @"User_Name"];
                    existingobject[@"User_Location"]=[currentuser objectForKey: @"User_Location"];
                    [existingobject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (!error) {
                            NSLog(@"item saved properly %@",self.currentProduct);
                            
                            [activityindicator stopAnimating];
                        }else{
                            NSLog(@"The Error from updating the Parse database is %@",error);
                        }
                    }];
                    
                    
                    
                    
                }else{
                    
                    
                    
                    // do stuff with the user
                    
                    NSLog(@"The Error from updating the Parse database is %@",error);
                    
                    
                    
                }
            }];
        }
    }





}
-(IBAction)sendtoshoplog:(id)sender{
    UIAlertView *sendtoshoplog=[[UIAlertView alloc]initWithTitle:@"Send to Shoplog" message:@"Do u Want to delegate Shoplog to inform the store that you are interested in this product ? " delegate:self cancelButtonTitle:@"NO Thanks!" otherButtonTitles:@"Yes Please!", nil];
    [sendtoshoplog show];
    }
-(IBAction)sharewithparse:(id)sender{
    activityindicator.hidden=NO;
    [activityindicator startAnimating];
    PFObject *shoplogitem = [PFObject objectWithClassName:@"shoplogobjectwall"];
    PFFile *file = [PFFile fileWithName:@"product_photo" data:[self.detailItem valueForKey:@"image"]];
    Shop *shopdetails=[self.detailItem shop];

    PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:[shopdetails latcoordinate] longitude:[shopdetails longcoordinate]];
    shoplogitem[@"categroyname"] = [self.detailItem valueForKey:@"categoryname"];
    shoplogitem[@"price"] = [self.detailItem valueForKey:@"price"];
    shoplogitem[@"rating"] = [self.detailItem valueForKey:@"rating"];
    shoplogitem[@"Dim_Size"] = [self.detailItem valueForKey:@"dim_size"];
    shoplogitem[@"shoplocation"] = point;
    shoplogitem[@"shopname"] = [shopdetails shopname];
    shoplogitem[@"website"] = [self.detailItem valueForKey:@"websiteurl"];
    shoplogitem[@"phone"] = [self.detailItem valueForKey:@"phone"];
    shoplogitem[@"email"] = [self.detailItem valueForKey:@"email"];
    shoplogitem[@"comments"] = [self.detailItem valueForKey:@"comments"];
    shoplogitem[@"productphoto"]=file;
    [shoplogitem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"item saved properly %@",self.currentProduct);
            [self.currentProduct setParseid:shoplogitem.objectId];
            self.managedObjectContext=self.currentProduct.managedObjectContext;
            //  Commit item to core data
            NSError *error;
            if (![self.managedObjectContext save:&error])
               NSLog(@"Unresolved error %@, %@, %@", error, [error userInfo],[error localizedDescription]);
            else{
                //NSLog(@"The New Item is :%@",self.currentProduct);
                NSLog(@"The New shop Item is %@ ",self.currentProduct);
                /*
                NSArray *permissions=@[@"public_profile", @"email", @"user_friends",@"publish_actions"];
                [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
                    if (!user) {
                        NSLog(@"Uh oh. The user cancelled the Facebook login.");
                    } else if (user.isNew) {
                        NSLog(@"User signed up and logged in through Facebook!");
                    } else {
                        NSLog(@"User logged in through Facebook!");
                    }
                }];
                */
            }

            [activityindicator stopAnimating];
        }
    }];
    


}


- (IBAction)MakeaCall:(id)sender {
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        NSString *phoneppp=@"tel:";
        
        NSString *Phone=[phoneppp stringByAppendingString:[[self.detailItem valueForKey:@"phone"] stringValue] ] ;
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:130-032-2837"]]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Phone]];
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:NSLocalizedString(@"Devicenotsupported", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
        
    }
}

- (IBAction)sendemail:(id)sender {
    NSArray *tomail=[[NSArray alloc]initWithObjects:[self.detailItem valueForKey:@"email"], nil];
    MFMailComposeViewController *picker=[[MFMailComposeViewController alloc]init];
    picker.mailComposeDelegate=self;
    [picker setSubject:NSLocalizedString(@"Product Information request", nil) ];
    [picker setToRecipients:tomail];
    [picker setMessageBody:NSLocalizedString(@"moreinfo", nil) isHTML:NO];
    [picker addAttachmentData:[self.detailItem valueForKey:@"image"] mimeType:@"image/png" fileName:@"Photos"];
    [self presentViewController:picker animated:YES completion:nil];
    
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)step1locationupdate:(double)longt latitude:(double)lat{
    //1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = lat;
    zoomLocation.longitude= longt;
    MKCoordinateSpan mapspan= MKCoordinateSpanMake(5, 5);
    // 2
    
    // Add the Annotation
    MyAnotation *annot = [[MyAnotation alloc] init];
    annot.coordinate = zoomLocation;
    [self.storelocation addAnnotation:annot];
    
    MKCoordinateRegion viewRegion=MKCoordinateRegionMake(zoomLocation, mapspan);
    // 3
    MKCoordinateRegion adjustedRegion = [storelocation regionThatFits:viewRegion];
    // 4
    [storelocation setRegion:adjustedRegion animated:YES];
    
    
}


@end
