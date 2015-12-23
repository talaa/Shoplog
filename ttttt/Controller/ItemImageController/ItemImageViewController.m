//
//  ItemImageViewController.m
//  ttttt
//
//  Created by Mena Bebawy on 12/13/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import "ItemImageViewController.h"
#import "Shoplog.h"
#import <MessageUI/MessageUI.h>
#import "SVProgressHUD.h"
#import "WebSiteViewController.h"
#import "DataParsing.h"
#import "DataTransferObject.h"
#import "Shop.h"
#import "AddProductDetailViewController.h"

@interface ItemImageViewController () <MFMailComposeViewControllerDelegate>
{
    Shoplog *shoplog;
    Shop *shop;
}

@end

@implementation ItemImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    shoplog = [self.itemDataMArray objectAtIndex:0];
    shop = shoplog.shop;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //load item image
    self.itemImageView.image = [UIImage imageWithData:self.itemImageData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/***************************************/
//          Action Button Pressed       //
/***************************************/

- (IBAction)actionPressed:(id)sender{
    UIAlertController *actionAlertController  = [UIAlertController alertControllerWithTitle:@"ShopLog" message:@"Choise what you would like to do." preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *editAction = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Code
        [self editItem];
    }];
    
    UIAlertAction *removeAction = [UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //code
        [self removeItem];
    }];
    
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Code
        [self makeACall];
    }];
    
    UIAlertAction *visitWebSiteAction = [UIAlertAction actionWithTitle:@"Visit Web Site" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Code
        [self performSegueWithIdentifier:@"VisitWebSiteSegu" sender:self];
    }];
    
    UIAlertAction *sendMailAction = [UIAlertAction actionWithTitle:@"Send Mail" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Code
        [self sendMail];
    }];
    
    [actionAlertController addAction:editAction];
    [actionAlertController addAction:removeAction];
    [actionAlertController addAction:callAction];
    [actionAlertController addAction:visitWebSiteAction];
    [actionAlertController addAction:sendMailAction];
    
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        //Ipad
        actionAlertController.popoverPresentationController.barButtonItem = self.actionBarButton;
    }else{
        //IPhone
    }
    [self presentViewController:actionAlertController animated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"VisitWebSiteSegu"]){
        WebSiteViewController *webSiteCV = segue.destinationViewController;
        webSiteCV.webSiteURL = shoplog.websiteurl;
    }else if ([segue.identifier isEqualToString:@"EditSegue"]){
        AddProductDetailViewController *addVC = segue.destinationViewController;
        addVC.isEdit = YES;
    }
}


/************************************/
//          Send Mail               //
/***********************************/

- (void)sendMail{
    if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        [picker setSubject:shoplog.categoryname];
        
        // Set up the recipients.
        NSArray *toRecipients = [NSArray arrayWithObjects:shoplog.email,nil];
        //NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com",@"third@example.com", nil];
        //NSArray *bccRecipients = [NSArray arrayWithObjects:@"four@example.com",nil];
        [picker setToRecipients:toRecipients];
        //[picker setCcRecipients:ccRecipients];
        //[picker setBccRecipients:bccRecipients];
        
        // Attach an image to the email.
        //    NSString *path = [[NSBundle mainBundle] pathForResource:@"ipodnano" ofType:@"png"];
        //    NSData *myData = [NSData dataWithContentsOfFile:path];
        [picker addAttachmentData:shoplog.image mimeType:@"attachment" fileName:shoplog.categoryname];
        
        NSString *body = [NSString stringWithFormat:@"I would ask about this item,please"];
        // Fill out the email body text.إ
        NSString *emailBody = body;
        [picker setMessageBody:emailBody isHTML:NO];
        
        // Present the mail composition interface.
        picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:picker animated:YES completion:NULL];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warring" message:@"Kindly enable at leat one e-mail account on this device" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }

}

/************************************/
//          Make a Call             //
/***********************************/

- (void)makeACall {
    NSURL* callUrl=[NSURL URLWithString:[NSString   stringWithFormat:@"tel:%@",shoplog.phone]];
    //check  Call Function available only in iphone
    if([[UIApplication sharedApplication] canOpenURL:callUrl])
    {
        [[UIApplication sharedApplication] openURL:callUrl];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"This is Simulator not a real device!!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


/********************************************/
//              Mail Delegare               //
/*******************************************/

// The mail compose view controller delegate method
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultSent:
            [SVProgressHUD showSuccessWithStatus:@"Your mail has been sent"];
            break;
        case MFMailComposeResultSaved:
            [SVProgressHUD showInfoWithStatus:@"You saved a draft of this email"];
            break;
        case MFMailComposeResultCancelled:
            [SVProgressHUD showInfoWithStatus:@"You cancelled sending this email."];
            break;
        case MFMailComposeResultFailed:
            [SVProgressHUD showErrorWithStatus:@"Mail failed:  An error occurred when trying to compose this email"];
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*******************************************/
//          Remove Item                    //
/*******************************************/

- (void)removeItem{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"Be Careful" message:@"Would you like to remove this item?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *remove = [UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //<#code#>
        [DataParsing removeEntityRecordbyItemId:shoplog.itemId AndEntityName:@"Shoplog"];
        //check if there aren't any items longer to a category, thus delete this category from core data
        [DataParsing removeCategoryInCaseOfNoItems:shoplog.categoryname];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    [alertcontroller addAction:remove];
    [alertcontroller addAction:cancel];
    [self presentViewController:alertcontroller animated:YES completion:nil];
    
}

/****************************************/
//          Edit Item                   //
/****************************************/

- (void)editItem{
    DataTransferObject *dTranferObje=[DataTransferObject getInstance];
    dTranferObje.defId          = shoplog.itemId;
    dTranferObje.defprice       = shoplog.price;
    dTranferObje.defcatqr       = shoplog.categoryname;
    dTranferObje.defimagedata   = shoplog.image;
    dTranferObje.defemail       = shoplog.email;
    dTranferObje.defphone       = [NSString stringWithFormat:@"%@",shoplog.phone];
    dTranferObje.defshopname    = shop.shopname;
    dTranferObje.defwebsiteurl  = shoplog.websiteurl;
    dTranferObje.deflat         = shop.latcoordinate;
    dTranferObje.deflong        = shop.longcoordinate;
    
    [self performSegueWithIdentifier:@"EditSegue" sender:self];
}


@end
