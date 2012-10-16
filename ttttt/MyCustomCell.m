//
//  MyCustomCell.m
//  ttttt
//
//  Created by Tamer Alaa on 9/18/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "MyCustomCell.h"

@implementation MyCustomCell
@synthesize celllabel,cellImage;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        celllabel.textColor=[UIColor blackColor];
        celllabel.backgroundColor=[UIColor redColor];
        //cellImage.frame=CGRectInset(cellImage.frame, 5, 5);
        /*
        //The Selection Code
        //UIView *bgView = [[UIView alloc]initWithFrame:self.backgroundView.frame];
        self.backgroundColor = [UIColor blueColor];
        
        self.layer.borderColor = [[UIColor whiteColor]CGColor];
        self.layer.borderWidth = 4;
        //self.selectedBackgroundView = bgView;
        */
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *bgView = [[UIView alloc]
                          initWithFrame:self.backgroundView.frame];
        //bgView.backgroundColor = [UIColor blueColor];
        bgView.layer.borderColor = [[UIColor blueColor]CGColor];
        bgView.layer.borderWidth = 4;
        self.selectedBackgroundView = bgView;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
