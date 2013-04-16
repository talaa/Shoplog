//
//  MosaicLayout.h
//  MosaicCollectionView
//

//

#import <UIKit/UIKit.h>
#import "MosaicViewController.h"

@interface MosaicLayout : UICollectionViewLayout{
    NSMutableArray *_columns;
    NSMutableArray *_itemsAttributes;
}

@property (weak) MosaicViewController *controller;
@property (assign) NSUInteger columnsQuantity;

-(float)columnWidth;

@end
