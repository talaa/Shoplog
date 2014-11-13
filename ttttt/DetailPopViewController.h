//
//  DetailPopViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 9/30/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Parse/Parse.h>
#import "AddProductDetailViewController.h"
#import "Flurry.h"
@class Shoplog;
@protocol MyPopoverDelegate <NSObject>
-(void)didClickdeleteButton;
@end

@interface DetailPopViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Shoplog *currentProduct;
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *Dimelabel;
@property (weak, nonatomic) IBOutlet UILabel *shoplabel;
@property (weak, nonatomic) IBOutlet UILabel *commentslabel;
@property (weak, nonatomic) IBOutlet UILabel *datelabel;
@property (weak,nonatomic) IBOutlet UIButton *deletebutton;
@property (weak,nonatomic) IBOutlet UIButton *editbutton;
@property (weak,nonatomic) IBOutlet UIImageView *imageid;
@property (nonatomic,strong)IBOutlet UIActivityIndicatorView *activityindicator;
@property (nonatomic, assign) id<MyPopoverDelegate> delegate; 
-(IBAction)deleteitem:(id)sender;
-(IBAction)MakeaCall:(id)sender ;
-(IBAction)sendemail:(id)sender;
@end
