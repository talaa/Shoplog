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
#import "Shoplogactivity.h"
#import "Fancysearch.h"
#import "EBaySearch.h"
#import "Amazonsearch.h"
#import "Taobaosearch.h"
#import "YahoobuySearch.h"
#import "GoogleShoppingSearch.h"
#import "Rakutensearch.h"
#import "Flurry.h"
#import "Shopzila.h"
#import "nexttagsearch.h"
#import "Shoppingcom.h"
#import "Shopzila.h"
#import "Shoppingcom.h"
#import "pricegrabbersearch.h"
#import "ECommerceWebViewController.h"

@interface ProductsViewControler ()
{
    NSOperationQueue    *operationQueue;
    NSString            *categoryName;
    NSString            *searchstringtitle;
    NSString            *searchWebSiteURLString;
    
}
@property (retain, nonatomic) CollectionReusableViewHeader *myheaderview;
@property (strong, nonatomic) NSMutableArray *productsByCategoryMArray;

@end

@implementation ProductsViewControler

- (void)viewDidLoad{
    [super viewDidLoad];
    
    operationQueue = [[NSOperationQueue alloc] init];
    
    //WebSeach Notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Searchactivated:) name:@"Searchactivated" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WebSearchactivated:) name:@"webSearchactivated" object:nil];

}

- (void)viewWillAppear:(BOOL)animated{
    //Load data
    [self loadProductsByCategory];
}

-(void)WebSearchactivated:(NSNotification*)notification {
    NSString *searchterm=[[notification userInfo] valueForKey:@"Searchwebsite"];
    searchstringtitle = [[notification userInfo]valueForKey:@"searchstring1"];
    searchWebSiteURLString=searchterm;
    [self performSegueWithIdentifier:@"ECommerceWebSegue" sender:self];
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
        headerView.searchButton.tag = indexPath.section;
        categoryName = shoplog.categoryname;
        self.myheaderview = headerView;
        reusableview = headerView;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}

/***********************************************/
#pragma mark - Search Button Pressed 
/***********************************************/

-(void)Searchactivated:(NSNotification*)notification {
    if ([[notification name] isEqualToString:@"Searchactivated"])
        NSLog(@"This is Value Passed :%@ ",[[notification userInfo] valueForKey:@"Searchterm"]);
    //Preparing the Search Term
    searchWebSiteURLString = nil;
    NSString *productNameString = [[notification userInfo] valueForKey:@"Searchterm"];
    NSArray *productNameArray=[NSArray arrayWithObject:productNameString];
    //Preparing the UIAcitvity Arrays of Objects
    Fancysearch     * Activity1 =   [[Fancysearch alloc]init];
    EBaySearch      * Activity2 =   [[EBaySearch alloc]init];
    Amazonsearch    * Activity3 =   [[Amazonsearch alloc]init];
    Rakutensearch   * Activity4 =   [[Rakutensearch alloc]init];
    Taobaosearch    * Activity5 =   [[Taobaosearch alloc]init];
    GoogleShoppingSearch * Activity6 =[[GoogleShoppingSearch alloc]init];
    YahoobuySearch  * Activity7 =   [[YahoobuySearch alloc]init];
    nexttagsearch   * Activity8 =   [[nexttagsearch alloc]init];
    Shoppingcom     * Activity9 =   [[Shoppingcom alloc]init];
    Shopzila        * Activity10    =[[Shopzila alloc]init];
    pricegrabbersearch *Activity11  =[[pricegrabbersearch alloc]init];
    
    
    //Activity1 set
    NSArray *Activityarray=[[NSArray alloc]initWithObjects:Activity1,Activity2,Activity3,Activity4,Activity5,Activity6,Activity7,Activity8,Activity9,Activity10,Activity11, nil];
    
    //Executing the Activity View Controller
    UIActivityViewController *activityViewController2 =[[UIActivityViewController alloc]initWithActivityItems:productNameArray applicationActivities:Activityarray];
    
    activityViewController2.excludedActivityTypes=@[UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeSaveToCameraRoll,UIActivityTypeMail,UIActivityTypeMessage,UIActivityTypePostToFacebook,UIActivityTypePostToTwitter];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        activityViewController2.popoverPresentationController.sourceView = self.myheaderview.searchButton;
    }
    
    [self presentViewController:activityViewController2 animated:YES completion:nil];

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
    if ([segue.identifier isEqualToString:@"ITemImageSegue"]){
        Shoplog *shoplog = [[self.productsByCategoryMArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        ItemImageViewController *itemImageVC = segue.destinationViewController;
        //NSData *imageData = UIImagePNGRepresentation(selectedCell.imageView.image);
        itemImageVC.itemImageData = shoplog.image;
        itemImageVC.itemDataMArray = [DataParsing fetchProductbyImageData:shoplog.image AndEntityName:@"Shoplog"];
    }
    else if ([segue.identifier isEqualToString:@"ECommerceWebSegue"]){
        ECommerceWebViewController *ecommerceVC = segue.destinationViewController;
        ecommerceVC.ecommerceTitle = searchstringtitle;
        ecommerceVC.ecommerceURLString = searchWebSiteURLString;
    }
}

     @end
