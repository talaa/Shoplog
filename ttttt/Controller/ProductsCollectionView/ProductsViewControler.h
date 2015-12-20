//
//  ProductsViewControler.h
//  ttttt
//
//  Created by Mena Bebawy on 12/8/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsViewControler : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *productsCollectionView;
@property (nonatomic, strong, readonly) NSMapTable *visibleCollectionReusableHeaderViews;

@end
