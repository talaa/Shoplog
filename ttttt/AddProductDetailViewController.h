//
//  AddProductDetailViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 9/25/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shoplog.h"
@class Shoplog;
@protocol addproductdetailviewcontrollerdelegate;
@interface AddProductDetailViewController : UITableViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPopoverControllerDelegate>


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) Shoplog *currentProduct;
@property (nonatomic ) BOOL edit_add;
@property (strong, nonatomic) IBOutlet UITextField *PriceField;
@property (strong, nonatomic) IBOutlet UITextField *ShopField;
@property (strong, nonatomic) IBOutlet UITextField *cataloguenamefield;
@property (strong, nonatomic) IBOutlet UIImageView *imageField;
@property (strong, nonatomic) IBOutlet UITextField *DimensionsField;
@property (strong, nonatomic) IBOutlet UITextField *comments;

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *Testnavigation;
@property (nonatomic,weak) id <addproductdetailviewcontrollerdelegate> delegate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Saveeditbutton;

@end
