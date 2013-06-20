//
//  ViewController.m
//  MosaicCollectionView
//
//

#import "MosaicViewController.h"
#import "MosaicLayout.h"
#import "MosaicCell.h"
#import "WebdetailViewController.h"
#import "CustomDataSource.h"
#import "TapForTap.h"
#import "Flurry.h"

@interface MosaicViewController()
-(void)updateColumnsQuantityToInterfaceOrientation:(UIInterfaceOrientation)anOrientation;

@end

@implementation MosaicViewController
@synthesize newelements,activityindicator;
#pragma mark - Private

static UIImageView *captureSnapshotOfView(UIView *targetView){
    UIImageView *retVal = nil;
    
    UIGraphicsBeginImageContextWithOptions(targetView.bounds.size, YES, 0);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    [[targetView layer] renderInContext:currentContext];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    retVal = [[UIImageView alloc] initWithImage:image];
    retVal.frame = [targetView frame];
    
    return retVal;
}
-(BOOL)checkinternetconnection{

NSString *feedname=@"http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=shoplog1&count=20";
    //NSError *anError = nil;
    NSURL *feedURL =[NSURL URLWithString:feedname];
    NSData *dataurl =[NSData dataWithContentsOfURL:feedURL];
    if (dataurl==NULL) {
        return NO;
    }else{
    
        return YES;
    }

}

-(void)updateColumnsQuantityToInterfaceOrientation:(UIInterfaceOrientation)anOrientation{
    //  Set the quantity of columns according of the device and interface orientation
    NSUInteger columns = 0;
    if (UIInterfaceOrientationIsLandscape(anOrientation)){
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
            columns = kColumnsiPadLandscape;
        }else{
            columns = kColumnsiPhoneLandscape;
        }
        
    }else{
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
            columns = kColumnsiPadPortrait;
        }else{
            columns = kColumnsiPhonePortrait;
        }
    }
    
    [(MosaicLayout *)self.collectionView.collectionViewLayout setColumnsQuantity:columns];
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"#DEBUG Touched %d", indexPath.row);
    //NSMutableArray *newelements=[[NSMutableArray alloc]initWithArray:];
    //NSLog(@"The String is %@",[[CustomDataSource _elements]objectAtIndex:indexPath.row]);
}
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    selectedindex=indexPath.row;
    [self performSegueWithIdentifier:@"gotowebdetail" sender:self];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"gotowebdetail"]) {
        WebdetailViewController *webdetailcontr = (WebdetailViewController *)[segue destinationViewController];
        //CustomDataSource *cds=[[CustomDataSource alloc]init];
        int cont=[cds._elements count];
        NSLog(@"The Elements are %d  & %d",cont,selectedindex);
        if (cont>0 && selectedindex<=cont-1) {
            
            [activityindicator stopAnimating];
            MosaicData *dta=[cds._elements objectAtIndex:selectedindex];
            
            NSLog(@"The url touched is %@",dta.url);
            [webdetailcontr setDetailurl:[NSURL URLWithString:dta.url]];
            webdetailcontr.hidesBottomBarWhenPushed = YES;
        }else{
            UIAlertView *pleasewait=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please Wait", nil)  message:NSLocalizedString(@"ImagesDownload", nil) delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [pleasewait show];
        
        
        
        }
        
        
    
    }



}

#pragma mark - Public
-(void)viewWillAppear:(BOOL)animated{
//cds=[[CustomDataSource alloc]init];
    [activityindicator startAnimating];
}
-(IBAction)refresh:(id)sender{

    cds=[[CustomDataSource alloc]init];
    NSLog(@"I am Refereshing");
    [self.collectionView reloadData];

}
- (void)viewDidLoad{
    [super viewDidLoad];
    /*
    if (![self checkinternetconnection]) {
        UIAlertView *nointernet=[[UIAlertView alloc]initWithTitle:@"OOOPS!" message:NSLocalizedString(@"Error downloading", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [nointernet show];
    }
     */
    [Flurry logEvent:@"mosaicview"];
    cds=[[CustomDataSource alloc]init];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.collectionView.delegate = self;
    [(CustomDataSource *)self.collectionView.dataSource setCollectionView:self.collectionView];
    
    [self updateColumnsQuantityToInterfaceOrientation:self.interfaceOrientation];
    [(MosaicLayout *)self.collectionView.collectionViewLayout setController:self];
    //TapforTap Part
    CGFloat y = self.view.frame.size.height - 50.0;
    TapForTapAdView *adView = [[TapForTapAdView alloc] initWithFrame: CGRectMake(0, y, 320, 50) delegate: self];
    [self.view addSubview: adView];
    [TapForTapInterstitial prepare];
    [TapForTapInterstitial showWithRootViewController: self]; 
    
}
- (UIViewController *) rootViewController {
    return self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    //  Taking a snapshot of the view before rotation to make a smooth transition on rotations
    _snapshotBeforeRotation = captureSnapshotOfView(self.collectionView);
    [self.view insertSubview:_snapshotBeforeRotation aboveSubview:self.collectionView];
    
    /*  Update columns when the device change from portrait to landscape or viceversa.
     *  After setting the columns to MosaicLayout, invalidate the layout to get the new
     *  setup. */
    [self updateColumnsQuantityToInterfaceOrientation:toInterfaceOrientation];
    MosaicLayout *layout = (MosaicLayout *)self.collectionView.collectionViewLayout;
    [layout invalidateLayout];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    _snapshotBeforeRotation.alpha = 0.0;

    _snapshotAfterRotation = captureSnapshotOfView(self.collectionView);
    [self.view insertSubview:_snapshotAfterRotation belowSubview:_snapshotBeforeRotation];
    self.collectionView.alpha = YES;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [_snapshotBeforeRotation removeFromSuperview];
    [_snapshotAfterRotation removeFromSuperview];
    _snapshotBeforeRotation = nil;
    _snapshotAfterRotation = nil;
    self.collectionView.hidden = NO;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

@end
