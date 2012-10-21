//
//  DetailViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 9/29/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "iCarousel.h"

@interface DetailViewController : UIViewController
//@property (nonatomic, retain) IBOutlet iCarousel *carousel;
@property (nonatomic,retain) NSManagedObjectContext *managaedobjectcontext;
@property (nonatomic, retain) NSArray *itemstransport;

@end
