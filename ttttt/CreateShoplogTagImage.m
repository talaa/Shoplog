//
//  CreateShoplogTagImage.m
//  ttttt
//
//  Created by Tamer Alaa on 10/16/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "CreateShoplogTagImage.h"

@implementation CreateShoplogTagImage


@synthesize shoplog;
- (UIImage*)Imagetag:(Shoplog*)selecteditem
{
    CGSize quoteSize = CGSizeMake(640, 960);
    UIGraphicsBeginImageContext(quoteSize);
    UIView *quoteView = [[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, quoteSize.width,
                                                  quoteSize.height)];
    //quoteView.backgroundColor = [UIColor blueColor];
    quoteView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backend.png"]];
    UIImageView *imageView = [[UIImageView alloc]
                              initWithImage:[UIImage imageWithData:selecteditem.image]];
    imageView.frame = CGRectMake(20, 20, 600, 320);
    imageView.backgroundColor = [UIColor clearColor];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [quoteView addSubview:imageView];
    UILabel *factLabel = [[UILabel alloc]
                          initWithFrame:CGRectMake(20, 360, 600, 600)];
    factLabel.backgroundColor = [UIColor clearColor];
    factLabel.numberOfLines = 10;
    factLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold"
                                     size:44];
    factLabel.backgroundColor=[UIColor colorWithRed:48.0f/255.0f green:74.0f/255.0f blue:147.0f/255.0f alpha:.75];
    factLabel.textColor = [UIColor whiteColor];
    //[factLabel setText:[shoplog categoryname];
    factLabel.text=[NSString stringWithFormat:@"Price : %.2f"
                    "\n Shop: %@ "
                    "\n Phone: %@ "
                    "\n Dim & Size :%@ ",selecteditem.price,selecteditem.shop.shopname,selecteditem.phone,selecteditem.dim_size];
    //factLabel.text = selecteditem.categoryname;
    factLabel.textAlignment = NSTextAlignmentCenter;
    [quoteView addSubview:factLabel];
    [quoteView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageToSave =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageToSave;
    //UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);
    //[self activityDidFinish:YES]
}
@end
