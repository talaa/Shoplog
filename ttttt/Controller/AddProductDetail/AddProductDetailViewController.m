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
#import "DataTransferObject.h"
#import "DataParsing.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "Category+CoreDataProperties.h"

@interface AddProductDetailViewController ()
{
    NSOperationQueue    *operationQueue;
    DataTransferObject  *dTranferObje;
    NSString            *productCoreDataID;
}

@end

@implementation AddProductDetailViewController
@synthesize managedObjectContext;
@synthesize PriceField,ShopField,imageField,cataloguenamefield;
@synthesize DimensionsField,PhoneField,EmailField,WebsiteField,commentsView;
@synthesize imagePicker,popoverController,edit_add,Saveeditbutton,newcatalogue;
@synthesize Maplocation,ratingslider,spinner,Qrcodecatalogue;
@synthesize longsaved,latsaved,gradientview;
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
        commentsView.delegate=self;
        DimensionsField.delegate=self;
        PhoneField.delegate=self;
        EmailField.delegate=self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set Product ID
    productCoreDataID = [DataParsing createRandomId];
    
    if (self.isEdit == YES){
        //Then it is an update view
        [self editExitItemBehaviorView];
    }else{
        //It is a new item
        [self newItemBehavior];
    }
    
    operationQueue = [[NSOperationQueue alloc] init];
    
    //self.view.backgroundColor=[UIColor greenColor];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"web-elements.png"]];
    //spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:self.view.center];
    //[spinner setCenter:CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0)]; // I do this because I'm in landscape mode
    [self.view addSubview:spinner]; // spinner is not visible until started
    
    
    ///Enabling the Catalogue Filed Name
    self.cataloguenamefield.enabled=YES;
    
    //Enabling the Done Button @ the Bottom
    if (edit_add) {
        self.Testnavigation.hidden=YES;
    } else {
        self.Testnavigation.hidden=NO;
    }
    //self.Testnavigation.hidden=YES;
    cataloguenamefield.text=self.title;
    if (Qrcodecatalogue) {
        //
        Qrcodecatalogue=NO;
    }
    
    [self configuregradient];
    //NSLog(@"The Supposed Saved values are %f %f",longsaved,latsaved);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}


-(void)viewWillAppear:(BOOL)animated{
    dTranferObje = [DataTransferObject getInstance];
    if (dTranferObje.defcatqr == nil){
        
    }else{
        self.LatTextField.text = [NSString stringWithFormat:@"%f",dTranferObje.deflat];
        self.LongTextfield.text = [NSString stringWithFormat:@"%f",dTranferObje.deflong];
        self.WebsiteField.text = dTranferObje.defwebsiteurl;
        self.ShopField.text = dTranferObje.defshopname;
        self.PhoneField.text = [NSString stringWithFormat:@"%@", dTranferObje.defphone];
        self.PriceField.text = [NSString stringWithFormat:@"%f",dTranferObje.defprice];
        self.cataloguenamefield.text = dTranferObje.defcatqr;
        if (self.isEdit == YES){
            //get from edit behavior
            self.imageField.image = [UIImage imageWithData:dTranferObje.defimagedata];
        }else{
            NSError* error = nil;
            NSURL *url = [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Facebook_Headquarters_Menlo_Park.jpg/2880px-Facebook_Headquarters_Menlo_Park.jpg"];
            NSData* data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
            if (error) {
                NSLog(@"%@", [error localizedDescription]);
            } else {
                NSLog(@"Data has loaded successfully.");
            }
            
            NSLog(@"Image usrl is %@", dTranferObje.defimagenameqr);
            if (self.imageField.image == nil){
                NSLog(@"empty");
            }else{
                NSLog(@"there is an image");
            }
        }
        
    }
    [self performSelector:@selector(updatecurrentLocation) withObject:nil afterDelay:5];
    /*
     if (self.currentProduct.shop.longcoordinate) {
     NSLog(@"i have Coordinates ");
     [self step1locationupdate];
     //[self step2locationupdate];
     } else {
     NSLog(@"i have Nothing ");
     [self step2locationupdate];
     }
     */
}


-(void)step1locationupdate{
    //1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = self.currentProduct.shop.latcoordinate;
    zoomLocation.longitude= self.currentProduct.shop.longcoordinate;
    MKCoordinateSpan mapspan= MKCoordinateSpanMake(2, 2);
    // 2
    
    // Add the Annotation
    MyAnotation *annot = [[MyAnotation alloc] init];
    annot.coordinate = zoomLocation;
    [self.Maplocation addAnnotation:annot];
    
    MKCoordinateRegion viewRegion=MKCoordinateRegionMake(zoomLocation, mapspan);
    // 3
    MKCoordinateRegion adjustedRegion = [Maplocation regionThatFits:viewRegion];
    // 4
    [Maplocation setRegion:adjustedRegion animated:YES];
    
    
}
-(void)step2locationupdate{
    Maplocation.showsUserLocation=YES;
    
    MKCoordinateRegion mapRegion;
    
    mapRegion.center.longitude=Maplocation.userLocation.coordinate.longitude;
    mapRegion.center.latitude=Maplocation.userLocation.coordinate.latitude;
    
    NSLog(@"The USer Location are :%f",mapRegion.center.latitude);
    
    mapRegion.span.latitudeDelta= 2;
    mapRegion.span.longitudeDelta= 2;
    
    [Maplocation setRegion:mapRegion animated:YES];
    NSLog(@"The USer Location are :%f %f",Maplocation.userLocation.coordinate.latitude,Maplocation.userLocation.coordinate.longitude);
}

-(void)configuregradient{
    //gradientview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)] ;
    UIColor *shoblue=[UIColor colorWithRed:19.0f/255.0f green:125.0f/255.0f blue:236.0f/255.0f alpha:1.0f];
    UIColor *shoorange=[UIColor colorWithRed:237.0f/255.0f green:146.0f/255.0f blue:18.0f/255.0f alpha:1.0f];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    float nnn;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        nnn=1.75f;
        //return YES; /* Device is iPad */
    }else{
        nnn=3.0f;
    }
    gradient.frame=CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height*nnn);
    //gradient.frame = self.tableView.bounds;
    NSLog(@"%f    %f",self.tableView.bounds.size.width,self.tableView.bounds.size.height);
    gradient.colors = [NSArray arrayWithObjects:(id)[shoorange CGColor], (id)[shoblue CGColor], nil];
    [self.tableView.layer insertSublayer:gradient atIndex:0];}

- (IBAction)Lgpraction:(id)sender {
    if (Lgpressgesture.state != UIGestureRecognizerStateBegan)
        return;
    NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:10];
    for (id annotation1 in Maplocation.annotations)
        if (annotation1 != Maplocation.userLocation)
            [toRemove addObject:annotation1];
    [Maplocation removeAnnotations:toRemove];
    CGPoint touchPoint = [Lgpressgesture locationInView:self.Maplocation];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.Maplocation convertPoint:touchPoint toCoordinateFromView:self.Maplocation];
    
    MyAnotation *annot = [[MyAnotation alloc] initWithCoordinate:touchMapCoordinate title:[self.currentProduct.shop shopname] subtitle:NSLocalizedString(@"The shop is here", nil)];
    //annot.coordinate = touchMapCoordinate;
    
    
    [self.Maplocation addAnnotation:annot];
    [LongTextfield setText:[NSString stringWithFormat:@"%f",annot.coordinate.longitude]];
    [LatTextField setText:[NSString stringWithFormat:@"%f",annot.coordinate.latitude]];
    self.currentProduct.shop.longcoordinate=annot.coordinate.longitude;
    self.currentProduct.shop.latcoordinate=annot.coordinate.latitude;
    
}


-(void)updatecurrentLocation{
    
    
    if (self.currentProduct.shop.longcoordinate) {
        NSLog(@"i have Coordinates ");
        [self step1locationupdate];
        //[self step2locationupdate];
    } else {
        NSLog(@"i have Nothing ");
        [self step2locationupdate];
    }
    /*
     Maplocation.showsUserLocation=YES;
     MKCoordinateRegion mapregion;
     mapregion.center=Maplocation.userLocation.coordinate;
     mapregion.span.latitudeDelta = 2;
     mapregion.span.longitudeDelta = 2;
     [Maplocation setRegion:mapregion animated: YES];
     */
}

- (IBAction)GetcurrentLocation1:(id)sender{
    NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:10];
    for (id annotation1 in Maplocation.annotations)
        if (annotation1 != Maplocation.userLocation)
            [toRemove addObject:annotation1];
    [Maplocation removeAnnotations:toRemove];
    
    Maplocation.showsUserLocation=YES;
    MKCoordinateRegion mapRegion;
    mapRegion.center = Maplocation.userLocation.coordinate;
    
    //NSLog(@"The USer Location are :%f %f",Maplocation.userLocation.coordinate.latitude,Maplocation.userLocation.coordinate.longitude);
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
- (IBAction)readQRcode:(id)sender {
    NSLog(@"I read QR Code");
    Qrcodecatalogue=YES;
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"The button Pressed is %ld",(long)buttonIndex);
    NSLog(@"The alert view is %@",alertView);
    PFUser *currentUser=[PFUser currentUser];
    NSDictionary *userdata=[[NSDictionary alloc]initWithObjectsAndKeys:[currentUser objectForKey:@"User_Name"],@"User_Name",[currentUser objectForKey:@"User_email"],@"User_email", nil];
    if (buttonIndex==1) {
        
        
        //Check if Shopdetails Are available;
        [Flurry logEvent:@"YES send to shoplog" withParameters:userdata timed:YES];
        NSLog(@"YES send to shoplog");
        
    }else{
        
        [Flurry logEvent:@"NO send to shoplog" withParameters:userdata timed:YES];
        NSLog(@"NO send to shoplog");
    }
}

/********************************************************/
//              Edit An Exit Item Action Button         //
/********************************************************/

- (IBAction)editExistButtonPressed:(id)sender{
    if (self.cataloguenamefield.text.length >0 && self.PriceField.text.length>0 && self.imageField.image != nil && self.ShopField.text.length>0 && self.PhoneField.text >0 && self.WebsiteField.text >0){
        dTranferObje.defcatqr           = self.cataloguenamefield.text;
        dTranferObje.defprice           = [self.PriceField.text floatValue];
        dTranferObje.defimagedata       = UIImagePNGRepresentation(self.imageField.image);
        dTranferObje.defshopname        = self.ShopField.text;
        dTranferObje.defrating          = self.ratingslider.value;
        dTranferObje.defphone           = self.PhoneField.text;
        dTranferObje.defwebsiteurl      = self.WebsiteField.text;
        
        [DataParsing editProductById:dTranferObje.defId AndEntityName:@"Shoplog"];
        [DataParsing dataTransferObjectDeAllocat];
        [SVProgressHUD showSuccessWithStatus:@"The product has been updated successfully."];
        [self.navigationController popToRootViewControllerAnimated:YES];

    }else{
        UIAlertController *alertController  = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Kindly fill all mandatory fields" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        }
}
/*******************************************************/
//              Save New Item Action Button             //
/*******************************************************/

- (IBAction)editSaveButtonPressed:(id)sender
{
    if (self.cataloguenamefield.text.length>0 && self.imageField.image != nil && self.PriceField.text.length>0 && self.ShopField.text.length>0){
        
        if (self.LatTextField.text.length>0 && self.LongTextfield.text.length>0){
            
            if ([self isProductExistOnCoreData] == NO){
                //save on Core data
                [self saveProductOnCoreData];
                [self saveProductOnParse];
            }else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warnning" message:@"You already had saved this item before." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:ok];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Press the button I am inside the shop to complete saving process" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Scan QR Code first.Press the button below.Or entre the data." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

/*
 ************* isProductExistOnCoreData *********************
*/

- (BOOL)isProductExistOnCoreData{
    dTranferObje = [DataTransferObject getInstance];
    //save imageurl as NSData
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:dTranferObje.defimagenameqr]];
    bool isExit = [DataParsing isProductExistsOnCDbyImageData:imageData ByEntity:@"Shoplog"];
    return isExit;
}

/******************************************/
#pragma mark - Save Product on Core Data
/******************************************/

- (void)saveProductOnCoreData {
    [SVProgressHUD showWithStatus:@"Saving Data..."];
    // Create Managed Object
    AppDelegate *app= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    //NSError *error;
    Shoplog *newShopLog = [NSEntityDescription
                           insertNewObjectForEntityForName:@"Shoplog"
                           inManagedObjectContext:context];
    
    
    NSData *imageData = UIImagePNGRepresentation(self.imageField.image);
    
    [newShopLog setValue:productCoreDataID forKey:@"itemId"];
    [newShopLog setValue:self.cataloguenamefield.text forKey:@"categoryname"];
    [newShopLog setValue:imageData forKey:@"image"];
    [newShopLog setValue:commentsView.text forKey:@"comments"];
    [newShopLog setValue:[NSDate date] forKey:@"date"];
    [newShopLog setValue:[NSNumber numberWithFloat:[self.PriceField.text floatValue]] forKey:@"price"];
    [newShopLog setValue:[NSNumber numberWithInt:self.ratingslider.value] forKey:@"rating"];
    if (self.DimensionsField.text>0){
        [newShopLog setValue:self.DimensionsField.text forKey:@"dim_size"];
    }
    if (self.EmailField.text.length>0){
        [newShopLog setValue:self.EmailField.text forKey:@"email"];
    }
    if (self.PhoneField.text>0){
        [newShopLog setValue:[NSDecimalNumber decimalNumberWithString:self.PhoneField.text] forKey:@"phone"];
    }
    if (self.WebsiteField.text.length>0){
        [newShopLog setValue:self.WebsiteField.text forKey:@"websiteurl"];
    }
    
    
    //Create Shop Core Data
    // Create Address
    Shop *newShop = [NSEntityDescription insertNewObjectForEntityForName:@"Shop" inManagedObjectContext:context];
    [newShop setValue:productCoreDataID forKey:@"shopId"];
    [newShop setValue:self.ShopField.text forKey:@"shopname"];
    [newShop setValue:[NSNumber numberWithDouble:[self.LatTextField.text doubleValue]] forKey:@"longcoordinate"];
    [newShop setValue:[NSNumber numberWithDouble:[self.LongTextfield.text doubleValue]] forKey:@"latcoordinate"];

    
    newShopLog.shop = newShop;
    
    NSError *errorRelation = nil;
    
    //Create Category Core Data
    // Check first if there is same exit
    if ([DataParsing ifCategoryNameExistOnEntit:@"Category" CategoryName:self.cataloguenamefield.text] == YES){
        //Exist no saving
    }else{
        //No Exist thus save it
        Category *category = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:context];
        [category setValue:self.cataloguenamefield.text forKey:@"catName"];
        if (![category.managedObjectContext save:&errorRelation]) {
            //had benn saved successfully
        }else{
            //hadn't been saved
        }
    }
    
    if (![newShopLog.managedObjectContext save:&errorRelation]) {
        [SVProgressHUD showErrorWithStatus:@"Sorry,failed to save data now please tray again!."];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"The product has been saved successfully."];
    }
    
    //Flush DataTansfer Public Object
    [DataParsing dataTransferObjectDeAllocat];
    [SVProgressHUD dismiss];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*****************************************************/
#pragma mark - SaveProductOnParseDB
/****************************************************/

- (void)saveProductOnParse{
    [operationQueue addOperationWithBlock:^{
        PFObject *saveFavorit = [PFObject objectWithClassName:@"SaveFavorit"];
        saveFavorit[@"category"]    = self.cataloguenamefield.text;
        saveFavorit[@"price"]       = self.PriceField.text;
        if (self.PhoneField.text>0){
            saveFavorit[@"phone"]       = self.PhoneField.text;
        }
        if (self.WebsiteField.text>0){
            saveFavorit[@"website"]     = self.WebsiteField.text;
        }
        saveFavorit[@"shop"]        = self.ShopField.text;
        saveFavorit[@"lat"]         = self.LatTextField.text;
        saveFavorit[@"long"]        = self.LongTextfield.text;
        NSData *imageData           = UIImagePNGRepresentation(self.imageField.image);
        PFFile *imageFile           = [PFFile fileWithName:@"image.png" data:imageData];
        saveFavorit[@"image"]       = imageFile;
        
        if ([PFUser currentUser]){
            saveFavorit[@"userId"]  = [PFUser currentUser].objectId;
        }
        
        [saveFavorit saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // The object has been saved.
                NSLog(@"Save Favorit on Parse Successfully");
                
            } else {
                // There was a problem, check error.description
                NSLog(@"Cant save Favorit successfully");
            }
        }];
    }];
    
}


-(void)preparetheitemtosave{
    //[spinner startAnimating];
    [self.currentProduct.shop setShopname:[ShopField text]];
    longsaved=[[LongTextfield text]floatValue];
    latsaved=[[LatTextField text]floatValue];
    [self.currentshop setLatcoordinate:latsaved ];
    [self.currentshop setLongcoordinate:longsaved];
    NSLog(@"Test 1 : %@",_currentProduct.shop.shopname);
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    float myNumber = [[PriceField text]floatValue];
    
    [self.currentProduct setPrice:myNumber];
    
    [self.currentProduct setCategoryname:[cataloguenamefield text]];
    
    NSLog(@"Test 2 : %i",_currentProduct.rating);
    [self.currentProduct setRating:ratingslider.value];
    [self.currentProduct setDim_size:[DimensionsField text]];
    [self.currentProduct setEmail:[EmailField text]];
    [self.currentProduct setWebsiteurl:[WebsiteField text]];
    [self.currentProduct setComments:[commentsView text]];
    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:[PhoneField text]];
    [self.currentProduct setPhone:decimal];
    
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
        //CGRect rect = CGRectMake(0.0, 0.0, newWidth, newHeight);
        CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
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
    [spinner stopAnimating];
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
        //NSLog(@"The New Item is :%@",self.currentProduct);
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
        //NSLog(@"The New Item is :%@",self.currentProduct);
        NSLog(@"The Old Shop is :%@",self.currentshop);
        //[controller.collectionView setNeedsLayout];
        //[controller didClickdeleteButton];
        //[self addobjecttoarray];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TestNotification" object:self];
    [spinner startAnimating];
    
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
    [commentsView resignFirstResponder];
    Saveeditbutton.enabled = YES;
    
    
    
    //[self.PriceField textFieldDidEndEditing:sender];
    [sender resignFirstResponder];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]) {
        [commentsView resignFirstResponder];
        return NO;
    }
    
    return YES;
    
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

///To be used Later on When Tweaking the Viewontroller
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 25)] ;
    UIImageView *headerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_gradient_blue"]] ;
    
    headerImage.frame = CGRectMake(0, 0, tableView.bounds.size.width, 25);
    UILabel *HeaderLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 29)];
    HeaderLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:24];
    HeaderLabel.backgroundColor=[UIColor clearColor];
    //HeaderLabel.backgroundColor=[UIColor colorWithRed:.2 green:.3 blue:.7 alpha:1];
    HeaderLabel.textColor=[UIColor whiteColor];
    switch (section) {
        case 0:
            HeaderLabel.text=NSLocalizedString(@"Categoryname", nil);
            break;
        case 1:
            HeaderLabel.text=NSLocalizedString(@"Image", nil) ;
            break;
        case 2:
            HeaderLabel.text=NSLocalizedString(@"Description",nil);
            break;
        case 3:
            HeaderLabel.text=NSLocalizedString(@"Store Contacts",nil);
            break;
        case 4:
            HeaderLabel.text=NSLocalizedString(@"Store Location",nil);
            break;
        case 5:
            HeaderLabel.text=NSLocalizedString(@"Comments",nil);
            break;
            
        default:
            break;
    }
    
    //[headerView addSubview:headerImage];
    [headerView addSubview:HeaderLabel];
    [headerView sendSubviewToBack:headerImage];
    
    return headerView;
}



- (IBAction)save:(UIStoryboardSegue *)segue{
}

#pragma The Text Fieled Adjustments Part
-(void)keyboardDidshow:(NSNotification*)notification{
    if (_keyboardisShown) return;
    
    Saveeditbutton.enabled = NO;
    
    NSDictionary *info =[notification userInfo];
    //Obtain the Size of the Keyboard
    NSValue *aValue=[info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect Keyboardrect=[self.view convertRect:[aValue CGRectValue] fromView:nil];
    NSLog(@"The Size of Keyboard is %f ",Keyboardrect.size.height);
    //resize the table view
    CGRect viewframe=[self.tableView frame];
    viewframe.size.height-=Keyboardrect.size.height;
    self.tableView.frame=viewframe;
    //scroll to the Current Field
}

-(IBAction)keyboardisalive:(id)sender{
    CGRect textfieldalive=[sender frame];
    NSLog(@"The Rectangle are %f",textfieldalive.size.height);
    [self.tableView scrollRectToVisible:textfieldalive animated:YES];
    
    
    
}

-(IBAction)textFieldDidBeginEditing:(UITextField *)textField:(id)sender{
    [sender becomeFirstResponder];

}
-(IBAction)textFieldDidEndEditing:(UITextField *)textField:(id)sender{

    [sender resignFirstResponder];

}

-(void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    //cell.backgroundColor=[UIColor colorWithRed:125.0f/255.0f green:125.0f/255.0f blue:125.0f/255.0f alpha:1];
    
    cell.backgroundColor=[UIColor clearColor];
}


/***************************************/
//      Edit Item Behavior              //
/****************************************/

- (void)editExitItemBehaviorView{
    self.scanQRButton.hidden = YES;
    self.scanQRButton.enabled = NO;
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editExistButtonPressed:)];
    NSArray *rightBarItems = @[editItem];
    self.navigationItem.rightBarButtonItems = rightBarItems;
}

/**************************************/
//      New Item Behavior             //
/**************************************/

- (void)newItemBehavior{
    self.scanQRButton.hidden = NO;
    self.scanQRButton.enabled = YES;
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(editSaveButtonPressed:)];
    NSArray *rightBarItems = @[saveItem];
    self.navigationItem.rightBarButtonItems = rightBarItems;
    [DataParsing dataTransferObjectDeAllocat];
}
@end
