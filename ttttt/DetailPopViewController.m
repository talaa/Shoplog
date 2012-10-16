//
//  DetailPopViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 9/30/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "DetailPopViewController.h"

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
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.pricelabel.text = [[self.detailItem valueForKey:@"price"] stringValue];
        self.shoplabel.text=[self.detailItem valueForKey:@"shop"];
        self.websitelabel.text=[self.detailItem valueForKey:@"websiteurl"];
        self.phonelabel.text=[[self.detailItem valueForKey:@"phone"]stringValue];
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

@end
