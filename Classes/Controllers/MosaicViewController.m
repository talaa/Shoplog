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
    /*
    CustomDataSource *cds=[[CustomDataSource alloc]init];
    MosaicData *dta=[cds._elements objectAtIndex:indexPath.row];
    NSLog(@"#Tamer Touched %@",dta.url);
    WebdetailViewController *webdetailcontr=[[WebdetailViewController alloc]initWithNibName:@"WebdetailViewController" bundle:nil];
    [webdetailcontr setDetailurl:[NSURL URLWithString:dta.url]];
[self.navigationController presentViewController:webdetailcontr animated:YES completion:nil];
     */
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"gotowebdetail"]) {
        WebdetailViewController *webdetailcontr = (WebdetailViewController *)[segue destinationViewController];
        //CustomDataSource *cds=[[CustomDataSource alloc]init];
        if (selectedindex <= [cds._elements count]-1 || !cds._elements  ) {
            NSLog(@"The Elements are %d",[cds._elements count]);
            [activityindicator stopAnimating];
            MosaicData *dta=[cds._elements objectAtIndex:selectedindex];
            
            NSLog(@"The url touched is %@",dta.url);
            [webdetailcontr setDetailurl:[NSURL URLWithString:dta.url]];
            webdetailcontr.hidesBottomBarWhenPushed = YES;
        }else{
            UIAlertView *pleasewait=[[UIAlertView alloc]initWithTitle:@"Please Wait" message:@"The Images are still Loading , Kindly wait " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
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
    [self.collectionView reloadData];

}
- (void)viewDidLoad{
    [super viewDidLoad];
    

    cds=[[CustomDataSource alloc]init];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.collectionView.delegate = self;
    [(CustomDataSource *)self.collectionView.dataSource setCollectionView:self.collectionView];
    
    [self updateColumnsQuantityToInterfaceOrientation:self.interfaceOrientation];
    [(MosaicLayout *)self.collectionView.collectionViewLayout setController:self];    
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
