//
//  QRcodereaderViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 5/11/14.
//  Copyright (c) 2014 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProductDetailViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QRcodereaderViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIButton *bbitemStart;
@property (nonatomic) AddProductDetailViewController *addviewcontroller;
- (IBAction)startStopReading:(id)sender;
@end
