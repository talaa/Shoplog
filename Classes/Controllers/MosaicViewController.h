//
//  ViewController.h
//  MosaicCollectionView
//

//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CustomDataSource.h"

#define kColumnsiPadLandscape 5
#define kColumnsiPadPortrait 4
#define kColumnsiPhoneLandscape 3
#define kColumnsiPhonePortrait 2

@interface MosaicViewController : UICollectionViewController{
    UIImageView *_snapshotBeforeRotation;
    UIImageView *_snapshotAfterRotation;
    NSInteger selectedindex;
    CustomDataSource *cds;

}
//@property (nonatomic, strong) NSOperationQueue *thumbnailQueue1;
@property (nonatomic,strong) NSMutableArray *newelements;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityindicator;
-(IBAction)refresh:(id)sender;
@end
