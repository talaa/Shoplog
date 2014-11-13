//
//  UpgradeViewController.h
//  Nokta100Lite
//
//  Created by Tamer Alaa on 7/18/12.
//  Copyright (c) 2012 NSN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#define KRated @"isalreadyrated"
#define KPROUprade @"isProversionpurchased"

@interface UpgradeViewController : UIViewController<SKProductsRequestDelegate,SKPaymentTransactionObserver>

@property (strong, nonatomic) SKProduct *product;
@property (retain,nonatomic) IBOutlet UIButton *buybutton;
@property (weak, nonatomic) IBOutlet UIButton *restorebutton;
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *spinner;
-(IBAction)buyproduct:(id)sender;
- (IBAction)restoreaction:(id)sender;
-(void)requestProductData;
@end
