//
//  ItemImageViewController.m
//  ttttt
//
//  Created by Mena Bebawy on 12/13/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import "ItemImageViewController.h"

@interface ItemImageViewController ()

@end

@implementation ItemImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"Call" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *visitWebSiteAction = [UIAlertAction actionWithTitle:@"Visit Web Site" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *sendMailAction = [UIAlertAction actionWithTitle:@"Send Mail" style:UIAlertActionStyleDefault handler:nil];
    
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

@end
