//
//  HeaderView.m
//  ttttt
//
//  Created by Tamer Alaa on 9/19/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView
@synthesize Headerviewlabel,searchButton,searchstring;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        Headerviewlabel.textColor=[UIColor blackColor];
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
