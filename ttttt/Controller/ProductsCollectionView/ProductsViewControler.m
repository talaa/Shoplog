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
#import "EAIntroView.h"
#import "AddProductDetailViewController.h"
#import "UpgradeViewController.h"

@interface ProductsViewControler () <EAIntroDelegate>
{
    NSString            *categoryName;
    NSString            *searchstringtitle;
    NSString            *searchWebSiteURLString;
    BOOL                 dontShowIntroAgain;
    UIView              *rootView;
    UIRefreshControl    *refreshControl;
}
@property (strong, nonatomic) NSMutableArray *productsByCategoryMArray;

@end

@implementation ProductsViewControler

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //Pull to refresh
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(startRefresh:)
             forControlEvents:UIControlEventValueChanged];
    [self.productsCollectionView addSubview:refreshControl];
    self.productsCollectionView.alwaysBounceVertical = YES;
    
    //check value on Intro Core data
    [self checkIntroCoreDataValue];
    
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

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [self.productsByCategoryMArray removeAllObjects];
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
   // _myheaderview = [_visibleCollectionReusableHeaderViews objectForKey:indexPath];
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
        headerView.searchButton.tag = indexPath;
        categoryName = shoplog.categoryname;
        [_visibleCollectionReusableHeaderViews setObject:headerView forKey:indexPath];
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
//    _myheaderview = [_visibleCollectionReusableHeaderViews objectForKey:indexPath];
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
        //activityViewController2.popoverPresentationController.sourceView = self.myheaderview.searchButton;
        
        // Remove arrow from action sheet.
        [activityViewController2.popoverPresentationController setPermittedArrowDirections:0];
        
        //For set action sheet to middle of view.
        activityViewController2.popoverPresentationController.sourceView = self.view;
        activityViewController2.popoverPresentationController.sourceRect = self.view.bounds;
    }
    
    [self presentViewController:activityViewController2 animated:YES completion:nil];

}

/**********************************************/
#pragma mark - LoadProductsbyCategory
/*********************************************/

- (void)loadProductsByCategory{
    self.productsByCategoryMArray = [[NSMutableArray alloc]init];
    [self.productsByCategoryMArray removeAllObjects];
    self.productsByCategoryMArray = [DataParsing fetchProductsbyCategory];
    [self.productsCollectionView reloadData];
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
    else if ([segue.identifier isEqualToString:@"AddNewItemSegue"]){
    }
    else if ([segue.identifier isEqualToString:@"GoProSegue"]){
    }
}

/****************************************************/
#pragma mark - Check Intro Core Data Value
/***************************************************/

- (void)checkIntroCoreDataValue{
    dontShowIntroAgain = [DataParsing dontShowIntroAgain];
    if (dontShowIntroAgain == YES){
        
    }else{
        rootView = self.tabBarController.view;
        EAIntroPage *page1 = [EAIntroPage page];
        page1.title = @"Hello world";
        page1.desc = @"sampleDescription1";
        page1.bgImage = [UIImage imageNamed:@"bg1"];
        page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title1"]];
        
        UIView *viewForPage2 = [[UIView alloc] initWithFrame:rootView.bounds];
        UILabel *labelForPage2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, rootView.bounds.size.width, 30)];
        labelForPage2.text = @"Some custom view";
        labelForPage2.font = [UIFont systemFontOfSize:32];
        labelForPage2.textColor = [UIColor whiteColor];
        labelForPage2.backgroundColor = [UIColor clearColor];
        labelForPage2.transform = CGAffineTransformMakeRotation(M_PI_2*3);
        [viewForPage2 addSubview:labelForPage2];
        EAIntroPage *page2 = [EAIntroPage pageWithCustomView:viewForPage2];
        page2.bgImage = [UIImage imageNamed:@"bg2"];
        
        EAIntroPage *page3 = [EAIntroPage page];
        page3.title = @"This is page 3";
        page3.desc = @"sampleDescription3";
        page3.bgImage = [UIImage imageNamed:@"bg3"];
        page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title3"]];
        
        EAIntroPage *page4 = [EAIntroPage page];
        page4.title = @"This is page 4";
        page4.desc = @"sampleDescription4";
        page4.bgImage = [UIImage imageNamed:@"bg4"];
        page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title4"]];
        
        EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1,page2,page3,page4]];
        [intro.skipButton setTitle:@"Skip now" forState:UIControlStateNormal];
        [intro.skipButton addTarget:self action:@selector(skipButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [intro setDelegate:self];
        
        [intro showInView:rootView animateDuration:0.3];
    }
}

- (void)skipButtonAction:(id)sender{
    [DataParsing setIntroValueToYES];
}

/***********************************************************/
#pragma mark -         Share Action     
/***********************************************************/
- (IBAction)shareButtonPressed:(id)sender {
    NSString *message = [NSString stringWithFormat:@"Shoplog is a shopping specialist app.Download it and enjoy your shopping\n\nhttps://itunes.apple.com/eg/app/shoplog/id557686446?mt=8"];
    UIImage *imageToShare = [UIImage imageNamed:@"shoplogIcon"];
    
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/eg/app/shoplog/id557686446?mt=8"];
    NSArray *postItems = @[message, url, imageToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:postItems
                                            applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

/***********************************************************/
#pragma mark -      Add New Item Segue  
/**********************************************************/
- (IBAction)addNewItemPressed:(id)sender {
    //get categories count if > 3 then no longer to add new categories
    NSInteger categoriesCount = [DataParsing returnFetchEntitiesArrayCounter:@"Category"];
    if (categoriesCount > 2){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oh!" message:@"Adding more than three categories requires upgrade to Pro version.Go ahead and press upgrade" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *goPro = [UIAlertAction actionWithTitle:@"Go Pro" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //<#code#>
            [self performSegueWithIdentifier:@"GoProSegue" sender:self];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
        
        [alertController addAction:goPro];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        [self performSegueWithIdentifier:@"AddNewItemSegue" sender:self];
    }
}

/****************************************************/
//      Observing that CollectionView End Loading
/****************************************************/
- (void)startRefresh:(id)sender{
    [self loadProductsByCategory];
    [refreshControl endRefreshing];
}

@end
