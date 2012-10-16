//
//  DetailPopViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 9/30/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProductDetailViewController.h"

@protocol MyPopoverDelegate <NSObject>
-(void)didClickdeleteButton;
@end

@interface DetailPopViewController : UIViewController
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *pricelabel;
@property (weak, nonatomic) IBOutlet UILabel *shoplabel;
@property (weak, nonatomic) IBOutlet UILabel *websitelabel;
@property (weak, nonatomic) IBOutlet UILabel *phonelabel;
@property (weak,nonatomic) IBOutlet UIButton *deletebutton;
@property (weak,nonatomic) IBOutlet UIButton *editbutton;
@property (nonatomic, assign) id<MyPopoverDelegate> delegate; 
-(IBAction)deleteitem:(id)sender;
@end
