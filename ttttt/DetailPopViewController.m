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
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        
        //Optionally for time zone converstions
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
        
        NSString *stringFromDate = [formatter stringFromDate:[self.detailItem valueForKey:@"date"]];

        self.datelabel.text=stringFromDate;
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
            UIAlertView *nourlalert=[[UIAlertView alloc]initWithTitle:@"NO Website" message:@"You have NOT saved any website in Shoplog" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [nourlalert show];
        }else{
            
            
        [brurl setBrowseuuurl:[[NSURL alloc]initWithString:[@"http://" stringByAppendingString:[self.detailItem valueForKey:@"websiteurl"]]]];
            [brurl setThetitle:[self.detailItem valueForKey:@"categoryname"]];
        //[brurl setTitle:[self.detailItem valueForKey:@"categoryname"]];
        
        }
         
    }

}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    /*
    UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(EditButtonPressed)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStyleBordered target:self action:@selector(DeleteButtonPressed)];
    
    self.title = @"My Title";
    
    [self.navigationItem setLeftBarButtonItem:cancelButton animated:NO];
    [self.navigationItem setRightBarButtonItem:okButton animated:NO];
     */
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
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
        
    }
}

- (IBAction)sendemail:(id)sender {
    NSArray *tomail=[[NSArray alloc]initWithObjects:[self.detailItem valueForKey:@"email"], nil];
    MFMailComposeViewController *picker=[[MFMailComposeViewController alloc]init];
    picker.mailComposeDelegate=self;
    [picker setSubject:@"Product Information request"];
    [picker setToRecipients:tomail];
    [picker setMessageBody:@"HELLO \n I would like to have more information about the attached Product \n Thank you \n\n\n Sent from Shoplog Application " isHTML:NO];
    [picker addAttachmentData:[self.detailItem valueForKey:@"image"] mimeType:@"image/png" fileName:@"Photos"];
    [self presentViewController:picker animated:YES completion:nil];
    
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{

    [controller dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)back:(UIStoryboardSegue *)segue
{
}
@end
