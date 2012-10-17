//
//  AddProductDetailViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 9/25/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "AddProductDetailViewController.h"
#import "TestViewController.h"
@interface AddProductDetailViewController ()

@end

@implementation AddProductDetailViewController
@synthesize managedObjectContext;
@synthesize PriceField,ShopField,imageField,cataloguenamefield;
@synthesize imagePicker,popoverController,edit_add,Saveeditbutton;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        cataloguenamefield.text=self.title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_currentProduct)
    {
        //[[PriceField setText:[[_currentProduct price]stringValue]];
         [PriceField setText:[NSString stringWithFormat:@"%2f", [_currentProduct price]]];
        [ShopField setText:[_currentProduct shop]];
        [self setTitle:[_currentProduct categoryname ]];
        if ([_currentProduct image])
            [imageField setImage:[UIImage imageWithData:[_currentProduct image]]];
    }
    if (edit_add) {
        self.Testnavigation.hidden=YES;
    } else {
        self.Testnavigation.hidden=NO;
    }
    //self.Testnavigation.hidden=YES;
    cataloguenamefield.text=self.title;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate


#pragma mark - Button actions

- (IBAction)editSaveButtonPressed:(id)sender
{
    
    // If we are adding a new picture (because we didnt pass one from the table) then create an entry
    if (!_currentProduct)
        self.currentProduct = (Shoplog *)[NSEntityDescription insertNewObjectForEntityForName:@"Shoplog"inManagedObjectContext:self.managedObjectContext];
    
    // For both new and existing pictures, fill in the details from the form
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    float myNumber = [[PriceField text]floatValue];
    //float myNumber = [f numberFromString:[PriceField text]];
    [self.currentProduct setPrice:myNumber];
    [self.currentProduct setShop:[ShopField text]];
    [self.currentProduct setCategoryname:[cataloguenamefield text]];
    
    if (imageField.image)
    {
        // Resize and save a smaller version for the table
        float resize = 120;
        float actualWidth = imageField.image.size.width;
        float actualHeight = imageField.image.size.height;
        float divBy, newWidth, newHeight;
        if (actualWidth > actualHeight) {
            divBy = (actualWidth / resize);
            newWidth = resize;
            newHeight = (actualHeight / divBy);
        } else {
            divBy = (actualHeight / resize);
            newWidth = (actualWidth / divBy);
            newHeight = resize;
        }
        CGRect rect = CGRectMake(0.0, 0.0, newWidth, newHeight);
        UIGraphicsBeginImageContext(rect.size);
        [imageField.image drawInRect:rect];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Save the small image version
        NSData *smallImageData = UIImageJPEGRepresentation(smallImage, 1.0);
        [self.currentProduct setImage:smallImageData];
    }
    
    //  Commit item to core data
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add new picture with error: %@", [error domain]);
    else{
        NSLog(@"The New Item is :%@",self.currentProduct);
        
    }
    
    
    
    //  Automatically pop to previous view now we're done adding
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)preparetheitemtosave{
    if (!_currentProduct)
        self.currentProduct = (Shoplog *)[NSEntityDescription insertNewObjectForEntityForName:@"Shoplog"inManagedObjectContext:self.managedObjectContext];
    // For both new and existing pictures, fill in the details from the form
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    float myNumber = [[PriceField text]floatValue];
    //float myNumber = [f numberFromString:[PriceField text]];
    [self.currentProduct setPrice:myNumber];
    [self.currentProduct setShop:[ShopField text]];
    [self.currentProduct setCategoryname:[cataloguenamefield text]];
    
    if (imageField.image)
    {
        // Resize and save a smaller version for the table
        float resize = 120;
        float actualWidth = imageField.image.size.width;
        float actualHeight = imageField.image.size.height;
        float divBy, newWidth, newHeight;
        if (actualWidth > actualHeight) {
            divBy = (actualWidth / resize);
            newWidth = resize;
            newHeight = (actualHeight / divBy);
        } else {
            divBy = (actualHeight / resize);
            newWidth = (actualWidth / divBy);
            newHeight = resize;
        }
        CGRect rect = CGRectMake(0.0, 0.0, newWidth, newHeight);
        UIGraphicsBeginImageContext(rect.size);
        [imageField.image drawInRect:rect];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Save the small image version
        NSData *smallImageData = UIImageJPEGRepresentation(smallImage, 1.0);
        [self.currentProduct setImage:smallImageData];
    }




}
- (void) viewWillDisappear: (BOOL) animated {
    [super viewWillDisappear: animated];
    //NSLog( @"In viewWillDisappear" );
    // Force any text fields that might be being edited to end so the text is stored
    [self.tableView.window endEditing: YES];
    [self.view.window endEditing:YES];
    
}
//  Pick an image from album
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
            [popover presentPopoverFromRect:self.imageField.bounds inView:self.imageField permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
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
-(void)savethediteditem{
    [self preparetheitemtosave];
    self.managedObjectContext=self.currentProduct.managedObjectContext;
    //  Commit item to core data
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"error info : %@", [error userInfo]);
    else{
        NSLog(@"The New Item is :%@",self.currentProduct);
    }
}

- (IBAction)savebuttonedit_OLD:(id)sender {
    [self preparetheitemtosave];
    //TestViewController *controller=[[TestViewController alloc]init];
    
    self.managedObjectContext=self.currentProduct.managedObjectContext;
    //  Commit item to core data
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"error info : %@", [error userInfo]);
    else{
        NSLog(@"The New Item is :%@",self.currentProduct);
        //[controller.collectionView setNeedsLayout];
        //[controller didClickdeleteButton];
        //[self addobjecttoarray];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TestNotification" object:self];

}







//  Resign the keyboard after Done is pressed when editing text fields
- (IBAction)resignKeyboard:(id)sender
{
    [PriceField resignFirstResponder];
    [ShopField resignFirstResponder];
    
    
    
    //[self textFieldDidEndEditing:sender];
    [sender resignFirstResponder];
}



#pragma mark - Image Picker Delegate Methods

//  Dismiss the image picker on selection and use the resulting image in our ImageView
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    [popoverController dismissPopoverAnimated:YES];
    [imageField setImage:image];
}

//  On cancel, only dismiss the picker controller
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}


@end
