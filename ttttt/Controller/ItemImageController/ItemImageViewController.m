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

@interface ItemImageViewController () <MFMailComposeViewControllerDelegate>
{
    Shoplog *shoplog;
}

@end

@implementation ItemImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    shoplog = [self.itemDataMArray objectAtIndex:0];
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
    UIAlertAction *editAction = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *removeAction = [UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Code
        [self makeACall];
    }];
    
    UIAlertAction *visitWebSiteAction = [UIAlertAction actionWithTitle:@"Visit Web Site" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *sendMailAction = [UIAlertAction actionWithTitle:@"Send Mail" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Code
        [self sendMail];
    }];
    
    [actionAlertController addAction:editAction];
    [actionAlertController addAction:removeAction];
    [actionAlertController addAction:callAction];
    [actionAlertController addAction:visitWebSiteAction];
    [actionAlertController addAction:sendMailAction];
    [actionAlertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil]];
    [self presentViewController:actionAlertController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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


@end
