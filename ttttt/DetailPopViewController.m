//
//  DetailPopViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 9/30/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "DetailPopViewController.h"
#import "WebViewController.h"

@interface DetailPopViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;

@end

@implementation DetailPopViewController
@synthesize delegate;
@synthesize activityindicator ,managedObjectContext,currentProduct;
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    self.masterPopoverController = nil;
}
-(IBAction)deleteitem:(id)sender{

//[self.collectionView deleteItemsAtIndexPaths:tempArray]
    //[self deleteObject:self.detailItem];
    //[self dismissModalViewControllerAnimated:YES];
    //[self.delegate didClickdeleteButton];
    NSManagedObject *managedobject=self.detailItem;
    NSManagedObjectContext *context=[managedobject managedObjectContext];
    [context deleteObject:managedobject];
    NSError *error;
    if (![context save:&error]) {
        // Handle the error.
        
    }
    
    
    [self.delegate didClickdeleteButton];
    //[self.masterPopoverController dismissPopoverAnimated:YES];
    //[self.masterPopoverController.delegate popoverControllerDidDismissPopover:self.masterPopoverController];
    //self.masterPopoverController=nil;
    
    //[self.masterPopoverController dismissPopoverAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [self configureView];
}
- (void)configureView
{
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Tag2.png"]];
    // Update the user interface for the detail item.
    //Shoplog *shoploginfo=self.detailItem;
    Shop *shopdetails=[self.detailItem shop];
    if (self.detailItem) {
        //self.Dimelabel.text = [[self.detailItem valueForKey:@"price"] stringValue];
        self.Dimelabel.text=[self.detailItem valueForKey:@"dim_size"];
        self.shoplabel.text=shopdetails.shopname;
        
        //self.shoplabel.text=[self.detailItem valueForKey:@"shop"];
        self.commentslabel.text=[self.detailItem valueForKey:@"comments"];
        [self.imageid setImage:[UIImage imageWithData:[self.detailItem valueForKey:@"image"]]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        
        //Optionally for time zone converstions
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
        
        NSString *stringFromDate = [formatter stringFromDate:[self.detailItem valueForKey:@"date"]];

        self.datelabel.text=stringFromDate;
        //Labels Fonts
        
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"EditDetail"]) {
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

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    activityindicator.hidden=YES;
    activityindicator.hidesWhenStopped=YES;
	// Do any additional setup after loading the view.
    /*
    UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(EditButtonPressed)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStyleBordered target:self action:@selector(DeleteButtonPressed)];
    
    self.title = @"My Title";
    
    [self.navigationItem setLeftBarButtonItem:cancelButton animated:NO];
    [self.navigationItem setRightBarButtonItem:okButton animated:NO];
     */
}
-(IBAction)sendtoshoplog:(id)sender{
    UIAlertView *sendtoshoplog=[[UIAlertView alloc]initWithTitle:@"Send to Shoplog" message:@"Do u Want to delegate Shoplog to inform the store that you are interested in this product ? " delegate:self cancelButtonTitle:@"No Thanks!" otherButtonTitles:@"Yes Please!", nil];
    [sendtoshoplog show];
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)EditButtonPressed:(id)sender{
    
    [self performSegueWithIdentifier:@"EditDetail" sender:sender];
    /*
    AddProductDetailViewController *editview=[[AddProductDetailViewController alloc]init];
    [editview setCurrentProduct:self.detailItem];
    [self.navigationController presentViewController:editview animated:YES completion:nil];
*/

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
        [Flurry logEvent:@"Phone call done" timed:YES];
        [RFRateMe showRateAlert];
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
    [Flurry logEvent:@"email sent" timed:YES];
    [RFRateMe showRateAlert];
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{

    [controller dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)back:(UIStoryboardSegue *)segue
{
}

#pragma send to shoplog
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

@end
