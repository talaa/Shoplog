//
//  HeaderView.m
//  ttttt
//
//  Created by Tamer Alaa on 9/19/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView
@synthesize Headerviewlabel,searchButton,searchstring,backgroundimage;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        Headerviewlabel.textColor=[UIColor blackColor];
        backgroundimage.image=[UIImage imageNamed:@"cloudy-sky-cartoon.jpg"];
        backgroundimage.center=self.center;
        //self.superview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"cloudy-sky-cartoon.jpg"]];
    }
    return self;
}
-(IBAction)saymyname:(id)sender{
    [PopoverView showPopoverAtPoint:searchButton.frame.origin inView:self withStringArray:[NSArray arrayWithObjects:@"Resfresh", @"Search", nil] delegate:self];

    NSLog(@"My Name is :%@",Headerviewlabel.text);
}
- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index{

     NSDictionary *dict = [NSDictionary dictionaryWithObject:Headerviewlabel.text forKey:@"Searchterm"];
    switch (index) {
        case 0:
            NSLog(@"%s item:%d", __PRETTY_FUNCTION__, index);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification" object:self userInfo:nil];
          
            break;
        case 1:
           
            NSLog(@"%s item:%d", __PRETTY_FUNCTION__, index);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"Searchactivated" object:self userInfo:dict];
            break;
        
    }

    

}
- (void)popoverViewDidDismiss:(PopoverView *)popoverView{
[popoverView performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];


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
