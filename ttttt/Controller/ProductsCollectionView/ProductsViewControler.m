//
//  ProductsViewControler.m
//  ttttt
//
//  Created by Mena Bebawy on 12/8/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import "ProductsViewControler.h"
#import "ProductCollectionViewCell.h"
#import "DataParsing.h"
#import "Shoplog.h"
#import "CollectionReusableViewHeader.h"
#import "ItemImageViewController.h"

@interface ProductsViewControler ()
{
    NSOperationQueue    *operationQueue;
    
}
@property (strong, nonatomic) NSMutableArray *productsByCategoryMArray;

@end

@implementation ProductsViewControler

- (void)viewDidLoad{
    [super viewDidLoad];
    
    operationQueue = [[NSOperationQueue alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    //Load data
    [self loadProductsByCategory];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/***********************************************/
#pragma mark - CollectionViewDataSource
/***********************************************/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[self.productsByCategoryMArray objectAtIndex:section] count]?[[self.productsByCategoryMArray objectAtIndex:section] count]:0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.productsByCategoryMArray count]?[self.productsByCategoryMArray count]:0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    ProductCollectionViewCell *cell = (ProductCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    //configure cell
    Shoplog *shoplog = [[self.productsByCategoryMArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.priceLabel.text = [NSString stringWithFormat:@"%f",shoplog.price];
    cell.imageView.image = [UIImage imageWithData:shoplog.image];
    cell.rateLabel.text = [NSString stringWithFormat:@"%d", shoplog.rating];
    cell.nameLabel.text = @"";
    
    cell.layer.cornerRadius = 7.0f;
    cell.layer.masksToBounds = YES;
    cell.layer.borderColor = [UIColor grayColor].CGColor;
    cell.layer.borderWidth = 1.5f;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

/***********************************************/
#pragma mark - CollectionViewDelegate
/***********************************************/

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionReusableViewHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        Shoplog *shoplog = [[self.productsByCategoryMArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        headerView.section.text = shoplog.categoryname;
        reusableview = headerView;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}

/**********************************************/
#pragma mark - LoadProductsbyCategory
/*********************************************/

- (void)loadProductsByCategory{
    [operationQueue addOperationWithBlock:^{
        [self.productsByCategoryMArray removeAllObjects];
        // Perform long-running tasks without blocking main thread
        self.productsByCategoryMArray = [DataParsing fetchProductsbyCategory];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // Main thread work (UI usually)
            [self.productsCollectionView reloadData];
        }];
    }];
}

/**************************************************/
#pragma mark - Navigator Segue      
/**************************************************/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [[self.productsCollectionView indexPathsForSelectedItems] lastObject];
    ProductCollectionViewCell *selectedCell =(ProductCollectionViewCell *)[self.productsCollectionView cellForItemAtIndexPath:indexPath];
    if ([segue.identifier isEqualToString:@"ITemImageSegue"]){
        ItemImageViewController *itemImageVC = segue.destinationViewController;
        NSData *imageData = UIImagePNGRepresentation(selectedCell.imageView.image);
        itemImageVC.itemImageData = imageData;
    }
}

     @end
