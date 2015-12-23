//
//  UpgradeViewController.m
//  Nokta100Lite
//
//  Created by Tamer Alaa on 7/18/12.
//  Copyright (c) 2012 NSN. All rights reserved.
//

#import "UpgradeViewController.h"
#import "Flurry.h"
#define kInAppPurchaseProUpgradeProductId @"6VJ733SKX8.com.springmoon.Shoplog.upgrade"
//#define kInAppPurchaseProUpgradeProductId @"com.springmoon.Shoplog.upgrade"
@interface UpgradeViewController ()

@end

@implementation UpgradeViewController
@synthesize buybutton,spinner,product;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSUserDefaults *userdefaults =[NSUserDefaults standardUserDefaults];
    if (![userdefaults boolForKey:KRated]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Rate me Please" message:@"If you like our App , Please Rate our App in the App Store" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *rateIt = [UIAlertAction actionWithTitle:@"Rate it" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //<#code#>
            NSString *link=@"https://itunes.apple.com/us/app/shoplog/id557686446?ls=1&mt=8";
            //NSString *link=@"http://www.google.com";
            
            //NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@, Anchorage, AK",addressString];
            NSString *escaped = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:escaped]];
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/shoplog/id557686446?ls=1&mt=8"]];
            
            NSLog(@"I will got to the app storee");
        }];
        
        UIAlertAction *later = [UIAlertAction actionWithTitle:@"Later" style:UIAlertActionStyleDestructive handler:nil];
        
        [alertController addAction:rateIt];
        [alertController addAction:later];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"web-elements.png"]];
    if ([SKPaymentQueue canMakePayments]) {
        NSLog(@"The Parental Control is Disabled");
    } else {
        // Warn the user that purchases are disabled.
        NSLog(@"The Parental Control is enabled");
    }
    buybutton.enabled=NO;
    //MyStoreObserver *observer = [[MyStoreObserver alloc] init];
    //[[SKPaymentQueue defaultQueue] addTransactionObserver:observer];
    //[self requestProductData];
    [spinner startAnimating];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSLog(@"The button Pressed is %d",buttonIndex);
//    if (buttonIndex==1) {
//        NSString *link=@"https://itunes.apple.com/us/app/shoplog/id557686446?ls=1&mt=8";
//        //NSString *link=@"http://www.google.com";
//        
//        //NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@, Anchorage, AK",addressString];
//        NSString *escaped = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:escaped]];
//        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/shoplog/id557686446?ls=1&mt=8"]];
//
//        NSLog(@"I will got to the app storee");
//        //[self performSegueWithIdentifier:@"upgrade" sender:self];
//    }
//    
//}

-(IBAction)buyproduct:(id)sender{

    SKPayment *payment=[SKPayment paymentWithProduct:product];
    //SKPayment *payment =[SKPayment paymentWithProductIdentifier:kInAppPurchaseProUpgradeProductId];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    [Flurry logEvent:@"upgrade is done " ];



}

- (IBAction)restoreaction:(id)sender {
    [[SKPaymentQueue defaultQueue]   restoreCompletedTransactions];
}




- (void) requestProductData
{
    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:
                                 [NSSet setWithObject: kInAppPurchaseProUpgradeProductId]];
    request.delegate = self;
    [request start];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    //NSArray *myProducts = response.products;
    // Populate your UI from the products list.
    // Save a reference to the products list.
    SKProduct *validproduct=nil;
    int count=[response.products count];
    if (count>0) {
        validproduct =[response.products objectAtIndex:0];
        product=validproduct;
        NSLog(@"Product title: %@" , validproduct.localizedTitle);
        NSLog(@"Product description: %@" , validproduct.localizedDescription);
        NSLog(@"Product price: %@" , validproduct.price);
        NSLog(@"Product id: %@" , validproduct.productIdentifier);
        buybutton.enabled=YES;
        [spinner stopAnimating];

            } else if(!validproduct) {
                NSLog(@"NO Products available");
                    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}
- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    //[self recordTransaction: transaction];
    [self provideContent: transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)recordTransaction:(SKPaymentTransaction *)transaction
{
    if ([transaction.payment.productIdentifier isEqualToString:kInAppPurchaseProUpgradeProductId])
    {
        // save the transaction receipt to disk
        [[NSUserDefaults standardUserDefaults] setValue:transaction.transactionReceipt forKey:@"proUpgradeTransactionReceipt" ];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled) {
        // Optionally, display an error here.
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
    NSLog(@"completeTransaction...");
    
    
        // Your application should implement these two methods.
    //[self recordTransaction:transaction];
    [self provideContent:transaction.payment.productIdentifier];
    
    // Remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    UIAlertView *congrat=[[UIAlertView alloc]initWithTitle:@"Congratulations" message:@"You are a PRO Shopper" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [congrat show];
}

- (void)provideContent:(NSString *)productId
{
    if ([productId isEqualToString:kInAppPurchaseProUpgradeProductId])
    {
        // enable the pro features
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey: KPROUprade ];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
