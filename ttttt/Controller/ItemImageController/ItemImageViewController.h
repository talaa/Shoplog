//
//  ItemImageViewController.h
//  ttttt
//
//  Created by Mena Bebawy on 12/13/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemImageViewController : UIViewController

@property (strong, nonatomic) NSData *itemImageData;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) NSMutableArray *itemDataMArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionBarButton;

- (IBAction)actionPressed:(id)sender;

@end
