//
//  QRcodereaderViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 5/11/14.
//  Copyright (c) 2014 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DataTransfer.h"

@interface QRcodereaderViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIButton *bbitemStart;
- (IBAction)startStopReading:(id)sender;
@end
