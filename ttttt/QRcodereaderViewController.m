//
//  QRcodereaderViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 5/11/14.
//  Copyright (c) 2014 Tamer Alaa. All rights reserved.
//

#import "QRcodereaderViewController.h"
#import "DataTransferObject.h"
#import "SVProgressHUD.h"
#import <Parse/Parse.h>
//#import "DataParsing.h"

@interface QRcodereaderViewController ()
@property (nonatomic) BOOL isReading;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) NSString *QRstring;
-(void)stopReading;
-(BOOL)startReading;

+(NSArray*)Qrdata:(NSString*)basicstring;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

-(void)loadBeepSound;
@end

@implementation QRcodereaderViewController

@synthesize viewPreview,lblStatus,bbitemStart,QRstring;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    //UIAlertView *helloQRCode=[[UIAlertView alloc]initWithTitle:@"Hello" message:@"Please Make Sure that the Shop is already registered with Sholog retailers Program, For More Information contact Shoplog@bluewavesolutions.net." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //[helloQRCode show];
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"Hello" message:@"Please Make Sure that the Shop is already registered with Sholog retailers Program, For More Information contact Shoplog@bluewavesolutions.net." preferredStyle:UIAlertControllerStyleAlert];
    [alertcontroller addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertcontroller animated:YES completion:nil];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataTransferMArray = [NSMutableArray new];
    QRstring=@"";
    _isReading = NO;
    _captureSession = nil;
    [self loadBeepSound];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startStopReading:(id)sender{
    if (!_isReading) {
        if ([self startReading]) {
            
            [bbitemStart setTitle:@"Stop" forState:UIControlStateNormal];
            [lblStatus setText:@"Scanning for QR Code..."];
        }
    }
    else{
        [self stopReading];
        [bbitemStart setTitle:@"Start!" forState:UIControlStateNormal];
    }
    
    _isReading = !_isReading;




}
- (BOOL)startReading {
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:viewPreview.layer.bounds];
    [viewPreview.layer addSublayer:_videoPreviewLayer];
    
    [_captureSession startRunning];
    
    return YES;

}
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            [lblStatus performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            QRstring=[metadataObj stringValue];
            NSArray *strings = [[metadataObj stringValue] componentsSeparatedByString:@","];
            
            if ([strings[0] isEqualToString:@"Shoplog"]) {
                
             [SVProgressHUD showWithStatus:@"Loading..."];
                
                //save data from QR Code to DataTranferObject Instance
                DataTransferObject *dTranferObje=[DataTransferObject getInstance];
                //dTranferObje.defId          = [DataParsing createRandomId];
                dTranferObje.defprice       = [strings[4] floatValue];
                dTranferObje.defcatqr       = strings[1];
                dTranferObje.defimagenameqr = strings[15];
                dTranferObje.defemail       = strings[7];
                dTranferObje.defphone       = strings[6];
                dTranferObje.defshopname    = strings[5];
                dTranferObje.defwebsiteurl  = strings[8];
                dTranferObje.deflat         = [strings[9] doubleValue];
                dTranferObje.deflong        = [strings[10] doubleValue];
                [dataTransferMArray addObject:dTranferObje];
                
            /*
            [DataTransfer setCategorynameQr:strings[1]];
            [DataTransfer setPriceQr:[strings[2] floatValue]];
            [DataTransfer setRatingQr:[strings[3] integerValue]];
            [DataTransfer setShopnameQr:strings[4]];
            [DataTransfer setdimSizeQr:strings[5]];
            [DataTransfer setlongshopQr:[strings[6] doubleValue]];
            [DataTransfer setlatshopQr:[strings[7] doubleValue]];
            [DataTransfer setphoneQr:[strings[8] doubleValue]];
            [DataTransfer setemailQr:strings[9]];
            [DataTransfer setwebsiteurlQr:strings[10]];
            [DataTransfer setcommentsQr:strings[11]];
             */
            //[self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            //[bbitemStart setTitle:@"Start!" forState:UIControlStateNormal];
            //[bbitemStart performSelectorOnMainThread:@selector(setTitle: forState:) withObject:@"Start!" waitUntilDone:NO];
            //_isReading = NO;
            //[self returnback_fillthedata];
            //[self.navigationController popToRootViewControllerAnimated:YES];
            /*[self dismissViewControllerAnimated:YES completion:^{
                [self returnback_fillthedata];
            }];
            */
            if (_audioPlayer) {
                [_audioPlayer play];
                [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
                _isReading = NO;
            }
            }else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warnning" message:@"This QR is not a Shoplog QR Code" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
                [self performSelectorOnMainThread:@selector(stopReadingNonShoplog) withObject:nil waitUntilDone:NO];
                _isReading = NO;
            
            }
        }
    }
}
-(void)stopReadingNonShoplog{
    [_captureSession stopRunning];
    [self.bbitemStart setTitle:@"Start" forState:UIControlStateNormal];
    _captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
    [SVProgressHUD dismiss];
    //get back to AddNewProduct View
    [self viewDidLoad];
}
-(void)returnback_fillthedata{

    _addviewcontroller.cataloguenamefield.text=[DataTransfer CategorynameQr];
    _addviewcontroller.PriceField.text=[NSString stringWithFormat:@"%f",[DataTransfer priceQr]];
    _addviewcontroller.ShopField.text=[DataTransfer shopnameQr];
    _addviewcontroller.DimensionsField.text=[DataTransfer dimSizeQr];

}
-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
     [SVProgressHUD dismiss];
    [_videoPreviewLayer removeFromSuperlayer];
     [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
-(void)loadBeepSound{
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    NSError *error;
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        [_audioPlayer prepareToPlay];
    }
}

-(void)seperatethemetadata:(NSString*)metadata{





}
+(NSArray*)Qrdata:(NSString*)basicstring{
NSArray *strings = [basicstring componentsSeparatedByString:@","];
    return strings;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end