//
//  AddProductDetailViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 9/25/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//
#define METERS_PER_MILE 1609.344
#import "AddProductDetailViewController.h"
#import "TestViewController.h"
#import "setlocationViewController.h"
@interface AddProductDetailViewController ()

@end

@implementation AddProductDetailViewController
@synthesize managedObjectContext;
@synthesize PriceField,ShopField,imageField,cataloguenamefield;
@synthesize DimensionsField,PhoneField,EmailField,WebsiteField;
@synthesize imagePicker,popoverController,edit_add,Saveeditbutton;
@synthesize Maplocation,ratingslider;
@synthesize longsaved,latsaved;
@synthesize LongTextfield,LatTextField,Lgpressgesture;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        cataloguenamefield.text=self.title;
        PriceField.delegate=self;
        ShopField.delegate=self;
        cataloguenamefield.delegate=self;
        //Maplocation.delegate=self;
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self performSelector:@selector(updatecurrentLocation) withObject:nil afterDelay:5];
    if (self.currentProduct.shop.longcoordinate) {
        NSLog(@"i have Coordinates ");
        [self step1locationupdate];
        //[self step2locationupdate];
    } else {
         NSLog(@"i have Nothing ");
        [self step2locationupdate];
    }

        }
-(void)step1locationupdate{
    //1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = self.currentProduct.shop.latcoordinate;
    zoomLocation.longitude= self.currentProduct.shop.longcoordinate;
    MKCoordinateSpan mapspan= MKCoordinateSpanMake(20, 20);
    // 2

    // Add the Annotation
    MyAnotation *annot = [[MyAnotation alloc] init];
    annot.coordinate = zoomLocation;
    [self.Maplocation addAnnotation:annot];
    //MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    MKCoordinateRegion viewRegion=MKCoordinateRegionMake(zoomLocation, mapspan);
    // 3
    MKCoordinateRegion adjustedRegion = [Maplocation regionThatFits:viewRegion];
    // 4
    [Maplocation setRegion:adjustedRegion animated:YES];


}
-(void)step2locationupdate{
    Maplocation.showsUserLocation=YES;
    
    MKCoordinateRegion mapRegion;
    
    mapRegion.center.longitude=self.currentProduct.shop.longcoordinate;
    mapRegion.center.latitude=self.currentProduct.shop.latcoordinate;
    
    NSLog(@"The USer Location are :%f",mapRegion.center.latitude);
    
    mapRegion.span.latitudeDelta= 2;
    mapRegion.span.longitudeDelta= 2;
    
    [Maplocation setRegion:mapRegion animated:YES];
    NSLog(@"The USer Location are :%f %f",Maplocation.userLocation.coordinate.latitude,Maplocation.userLocation.coordinate.longitude);



}

- (void)viewDidLoad
{
 
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"web-elements.png"]];
    
    
    [super viewDidLoad];
    if (_currentProduct)
    {
        //[[PriceField setText:[[_currentProduct price]stringValue]];
         [PriceField setText:[NSString stringWithFormat:@"%.2f", [_currentProduct price]]];
        [ShopField setText:[_currentProduct.shop shopname]];
        [LongTextfield setText:[NSString stringWithFormat:@"%f",[_currentProduct.shop longcoordinate]]];
        [LatTextField setText:[NSString stringWithFormat:@"%f",[_currentProduct.shop latcoordinate]]];
        longsaved=[_currentProduct.shop longcoordinate];
        latsaved=[_currentProduct.shop latcoordinate];
        
        [self setTitle:[_currentProduct categoryname ]];
        [ratingslider setValue:[_currentProduct rating] animated:YES];
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
   
    //NSLog(@"The Supposed Saved values are %f %f",longsaved,latsaved);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    


    
    
}

- (IBAction)Lgpraction:(id)sender {
    if (Lgpressgesture.state != UIGestureRecognizerStateBegan)
        return;
    NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:10];
    for (id annotation in Maplocation.annotations)
        if (annotation != Maplocation.userLocation)
            [toRemove addObject:annotation];
    [Maplocation removeAnnotations:toRemove];
    CGPoint touchPoint = [Lgpressgesture locationInView:self.Maplocation];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.Maplocation convertPoint:touchPoint toCoordinateFromView:self.Maplocation];
    
    MyAnotation *annot = [[MyAnotation alloc] init];
    annot.coordinate = touchMapCoordinate;
    [self.Maplocation addAnnotation:annot];
    [LongTextfield setText:[NSString stringWithFormat:@"%f",annot.coordinate.longitude]];
    [LatTextField setText:[NSString stringWithFormat:@"%f",annot.coordinate.latitude]];
    self.currentProduct.shop.longcoordinate=annot.coordinate.longitude;
    self.currentProduct.shop.latcoordinate=annot.coordinate.latitude;
    
}

- (IBAction)setshoplocation:(id)sender {
    
    setlocationViewController *locationviewcontrol=[[setlocationViewController alloc]init];
    //locationviewcontrol.shoplocationlat=self.currentProduct.shop.latcoordinate;
    //locationviewcontrol.shoplocationlong=self.currentProduct.shop.longcoordinate;
    locationviewcontrol.shoplocationlat=Maplocation.userLocation.coordinate.latitude;
    locationviewcontrol.shoplocationlong=Maplocation.userLocation.coordinate.longitude;
    locationviewcontrol.managedObjectcontext=self.managedObjectContext;
}
-(void)updatecurrentLocation{

    Maplocation.showsUserLocation=YES;
    MKCoordinateRegion mapregion;
    mapregion.center=Maplocation.userLocation.coordinate;
    mapregion.span.latitudeDelta = 2;
    mapregion.span.longitudeDelta = 2;
    [Maplocation setRegion:mapregion animated: YES];
}

- (IBAction)GetcurrentLocation1:(id)sender{
    
    
    Maplocation.showsUserLocation=YES;
    MKCoordinateRegion mapRegion;
    mapRegion.center = Maplocation.userLocation.coordinate;
    
    NSLog(@"The USer Location are :%f %f",Maplocation.userLocation.coordinate.latitude,Maplocation.userLocation.coordinate.longitude);
    mapRegion.span.latitudeDelta = 2;
    mapRegion.span.longitudeDelta = 2;
    //self.currentProduct.shop.longcoordinate=Maplocation.userLocation.coordinate.longitude;
    //self.currentProduct.shop.latcoordinate=Maplocation.userLocation.coordinate.latitude;
    
    self.currentProduct.shop.longcoordinate=Maplocation.userLocation.coordinate.longitude;
    self.currentProduct.shop.latcoordinate=Maplocation.userLocation.coordinate.latitude;
    [LongTextfield setText:[NSString stringWithFormat:@"%f",Maplocation.userLocation.coordinate.longitude]];
    [LatTextField setText:[NSString stringWithFormat:@"%f",Maplocation.userLocation.coordinate.latitude]];
    
    annotation =[[MyAnotation alloc]initWithCoordinate:CLLocationCoordinate2DMake(Maplocation.userLocation.coordinate.latitude, Maplocation.userLocation.coordinate.longitude) title:[self.currentProduct.shop shopname] subtitle:@"The shop is here"];
    [Maplocation addAnnotation:annotation];
    [Maplocation setRegion:mapRegion animated: YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"setshoploc"]) {
    //setlocationViewController *sholocatviewcontroller=(setlocationViewController*)[segue destinationViewController];
        //[self presentViewController:sholocatviewcontroller animated:YES completion:nil];
    //sholocatviewcontroller.shoplocationlong=50 ;
    //sholocatviewcontroller.shoplocationlat=-120;
    }


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source






#pragma mark - Table view delegate
- (IBAction)RatingSlidervalue:(id)sender {
    [self.currentProduct setRating:ratingslider.value];
    
}


#pragma mark - Button actions

- (IBAction)editSaveButtonPressed:(id)sender
{
    
    // If we are adding a new picture (because we didnt pass one from the table) then create an entry
    if (!_currentProduct)
        self.currentProduct = (Shoplog *)[NSEntityDescription insertNewObjectForEntityForName:@"Shoplog"inManagedObjectContext:self.managedObjectContext];
    if(!_currentshop)
        self.currentshop=(Shop*)[NSEntityDescription insertNewObjectForEntityForName:@"Shop" inManagedObjectContext:self.managedObjectContext];
    
    // For both new and existing pictures, fill in the details from the form
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    float myNumber = [[PriceField text]floatValue];
    //int myintNumber=[[ratingField text]integerValue];
    //float myNumber = [f numberFromString:[PriceField text]];
    [self.currentProduct setPrice:myNumber];
    [self.currentshop setShopname:[ShopField text]];
    longsaved=[[LongTextfield text]floatValue];
    latsaved=[[LatTextField text]floatValue];
    
    [self.currentshop setLatcoordinate:latsaved ];
    [self.currentshop setLongcoordinate:longsaved];
    [self.currentProduct setCategoryname:[cataloguenamefield text]];
    [self.currentProduct setRating:ratingslider.value];
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
    [self.currentshop setShopdetails:self.currentProduct];
    [self.currentProduct setShop:self.currentshop];
    
    //  Commit item to core data
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add new picture with error: %@", [error domain]);
    else{
        NSLog(@"The New Item is :%@",self.currentProduct);
        NSLog(@"The New shop Item is %@ ",self.currentshop);
        
    }
    
    
    
    //  Automatically pop to previous view now we're done adding
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)preparetheitemtosave{
    [self.currentProduct.shop setShopname:[ShopField text]];
    longsaved=[[LongTextfield text]floatValue];
    latsaved=[[LatTextField text]floatValue];
    [self.currentshop setLatcoordinate:latsaved ];
    [self.currentshop setLongcoordinate:longsaved];
    NSLog(@"Test 1 : %@",_currentProduct.shop.shopname);
    // For both new and existing pictures, fill in the details from the form
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    float myNumber = [[PriceField text]floatValue];
    //int myintNumber=[[ratingField text]integerValue];
    //float myNumber = [f numberFromString:[PriceField text]];
    
    [self.currentProduct setPrice:myNumber];
    //[self.currentshop setShopname:[ShopField text]];
    [self.currentProduct setCategoryname:[cataloguenamefield text]];
    
    //[self.currentProduct setRating:myintNumber];
    NSLog(@"Test 2 : %i",_currentProduct.rating);
    [self.currentProduct setRating:ratingslider.value];
    
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
    longsaved=0;
    latsaved=0;
    
    
    
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
    //self.managedObjectContext=self.currentshop.managedObjectContext;
    self.managedObjectContext=self.currentProduct.managedObjectContext;
    //  Commit item to core data
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"error info : %@", [error userInfo]);
    else{
        NSLog(@"The New Item is :%@",self.currentProduct);
        NSLog(@"The New shop Item is %@ ",self.currentshop);
    }
}

- (IBAction)savebuttonedit_OLD:(id)sender {
    [self preparetheitemtosave];
    //TestViewController *controller=[[TestViewController alloc]init];
    //self.managedObjectContext=self.currentshop.managedObjectContext;
    self.managedObjectContext=self.currentProduct.managedObjectContext;
    //  Commit item to core data
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"error info : %@", [error userInfo]);
    else{
        NSLog(@"The New Item is :%@",self.currentProduct);
        NSLog(@"The New Shop is :%@",self.currentshop);
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
    [cataloguenamefield resignFirstResponder];
    [PriceField resignFirstResponder];
    [ShopField resignFirstResponder];
    [PhoneField resignFirstResponder];
    [DimensionsField resignFirstResponder];
    [EmailField resignFirstResponder];
    [WebsiteField resignFirstResponder];
    
    
    
    
    //[self.PriceField textFieldDidEndEditing:sender];
    [sender resignFirstResponder];
}
- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [txtView resignFirstResponder];
    return NO;
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
/*
///To be used Later on When Tweaking the Viewontroller 
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] autorelease];
    UIImageView *headerImage = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top-gery-bar.png"]] autorelease];
    
    headerImage.frame = CGRectMake(0, 0, tableView.bounds.size.width, 30);
    
    [headerView addSubview:headerImage];
    
    return headerView;
}
 
 */
- (IBAction)save:(UIStoryboardSegue *)segue
{
}

@end
