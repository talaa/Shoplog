//
//  MyCustomCell.h
//  ttttt
//
//  Created by Tamer Alaa on 9/18/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MyCustomCell : UICollectionViewCell
@property (nonatomic,retain) IBOutlet UILabel *celllabel;
@property (nonatomic,retain) IBOutlet UILabel *ratinglabel;
@property (nonatomic,retain) IBOutlet UIImageView *cellImage;
@end
