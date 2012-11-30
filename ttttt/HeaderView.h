//
//  HeaderView.h
//  ttttt
//
//  Created by Tamer Alaa on 9/19/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverView.h"
#import "TestViewController.h"

@interface HeaderView : UICollectionReusableView<PopoverViewDelegate>
@property (nonatomic,retain) IBOutlet UILabel *Headerviewlabel;
@property (nonatomic,strong) IBOutlet UIButton *searchButton;
@property (nonatomic,strong) IBOutlet UIImageView *backgroundimage;
@property (nonatomic,strong)NSString *searchstring;
@end
