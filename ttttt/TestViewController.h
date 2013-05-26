//
//  TestViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 9/16/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <QuartzCore/QuartzCore.h>
#import "UIPopover+Iphone.h"
#import "MyCustomCell.h"
#import "HeaderView.h"
#import "DetailPopViewController.h"
#import "PopoverView.h"
#import "AdFooterview.h"
#import "LAWalkthroughViewController.h"


#define KPROUprade @"isProversionpurchased"
#define KRated @"isalreadyrated"
@class MyCustomCell;
@class HeaderView;
@class AdFooterview;
@interface TestViewController : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate,NSFetchedResultsControllerDelegate,UIPopoverControllerDelegate,MyPopoverDelegate,MFMailComposeViewControllerDelegate,PopoverViewDelegate,UIAlertViewDelegate>{


    //IBOutlet UIViewController *popoverinview;


}
//@property (strong,nonatomic) Shoplog *newimportedarray;
@property (nonatomic,retain)NSMutableArray *testarray;
@property (nonatomic,retain ) UIPopoverController *mypopover;
@property (nonatomic,strong) DetailPopViewController *detailPopViewController;
@property (nonatomic,retain)MyCustomCell *mycustomcell;
@property (nonatomic,retain)HeaderView *myheaderview;
@property (nonatomic) BOOL sharing;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//The sharing Part 
@property(nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *sharebutton;
@property(nonatomic, strong) NSMutableArray *searcharray;
@property(nonatomic, strong) NSString *searchstring;
//-(void)showmailcomposer:(NSData*)datafile;
- (void)handleOpenURL:(NSURL *)url;
//- (void)reloadFetchedResults:(NSNotification*)note;
@end
