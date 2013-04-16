//
//  MyCustomCell.m
//  ttttt
//
//  Created by Tamer Alaa on 9/18/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "MyCustomCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyCustomCell
@synthesize celllabel,cellImage,ratinglabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //NSLog(@"ia ammaam");
        //celllabel.textColor=[UIColor blackColor];
        //celllabel.backgroundColor=[UIColor redColor];
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

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.layer.cornerRadius = 25.0;
    CALayer *jjj=[cellImage layer];
    [jjj setMasksToBounds:YES];
    [jjj setCornerRadius:20];
    
    /*
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = self.layer.bounds;
    imageLayer.cornerRadius = 10.0;
    imageLayer.contents=(id) [cellImage image].CGImage;
    //imageLayer.contents = (id) [UIImage imageNamed:@"BattleMapSplashScreen.jpg"].CGImage;
    //imageLayer.masksToBounds = YES;
    [self.layer addSublayer:imageLayer];
    */
    //cellImage.layer.cornerRadius=25.0;
    self.layer.shadowOffset = CGSizeMake(0, 10);
    self.layer.shadowRadius = 5.0;
    self.layer.shadowColor = [UIColor whiteColor].CGColor;
    
    self.layer.shadowOpacity = 0.3;
    // Drawing code
}


@end
