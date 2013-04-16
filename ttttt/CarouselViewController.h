//
//  CarouselViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 1/8/13.
//  Copyright (c) 2013 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
//#import "AsyncImageView.h"


@interface CarouselViewController : UIViewController<iCarouselDataSource, iCarouselDelegate>
@property (nonatomic, retain) IBOutlet iCarousel *carousel;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *background;

@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UIImageView *usericon;
@property (nonatomic, retain)NSString *maintext;
@property (nonatomic, retain)NSString *originaluser;
@property (nonatomic,retain)NSURL *linktogo;
@property (nonatomic,retain)NSArray *tweets;
@property (nonatomic)BOOL tweetsfinished;
@property (nonatomic, retain)UIImage *origimage;
@property (weak, nonatomic) IBOutlet UIButton *Buttonclick;
- (IBAction)Gotolink:(id)sender;
- (IBAction)Refresh:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Refreshbutton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *ContentActivity;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Provideractivity;

@end
