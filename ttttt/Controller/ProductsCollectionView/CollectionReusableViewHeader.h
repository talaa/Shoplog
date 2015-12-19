//
//  CollectionReusableViewHeader.h
//  ttttt
//
//  Created by Mena Bebawy on 12/8/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionReusableViewHeader : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *section;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

-(IBAction)searchButtonPressed:(id)sender;
@end
