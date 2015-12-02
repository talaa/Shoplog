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

@interface QRcodereaderViewController ()
{
    NSMutableArray *dataTransferMArray;
}
@property (nonatomic) BOOL isReading;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) NSString *QRstring;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
-(void)stopReading;
-(BOOL)startReading;



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
    [super viewDidLoad];
    
    dataTransferMArray = [NSMutableArray new];
    
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"Hello" message:@"Please Make Sure that the Shop is already registered with Sholog retailers Program, For More Information contact Shoplog@bluewavesolutions.net." preferredStyle:UIAlertControllerStyleAlert];
    [alertcontroller addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertcontroller animated:YES completion:nil];
    
    
    // Do any additional setup after loading the view.
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
            [self.bbitemStart setTitle:@"Stop" forState:UIControlStateNormal];
        }
    }
    else{
        [self stopReading];
        [self.bbitemStart setTitle:@"Start" forState:UIControlStateNormal];
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
            //save data
            QRstring=[metadataObj stringValue];
            NSLog(@"Code is %@", QRstring);
            NSArray *strings = [[metadataObj stringValue] componentsSeparatedByString:@","];
            [SVProgressHUD showWithStatus:@"Loading..."];
            //save data from QR Code to DataTranferObject Instance
            DataTransferObject *dTranferObje=[DataTransferObject getInstance];
            dTranferObje.defprice = [strings[3] floatValue];
            dTranferObje.defcatqr = strings[0];
            dTranferObje.defimagenameqr = strings[14];
            dTranferObje.defemail = strings[6];
            dTranferObje.defphone = strings[5];
            dTranferObje.defshopname = strings[4];
            dTranferObje.defwebsiteurl = strings[7];
            dTranferObje.deflat = [strings[8] doubleValue];
            dTranferObje.deflong = [strings[9] doubleValue];
            [dataTransferMArray addObject:dTranferObje];
            
            // If the audio player is not nil, then play the sound effect.
            if (_audioPlayer) {
                [_audioPlayer play];
            }
            
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            _isReading = NO;
        }
    }
}

-(void)stopReading{
    [_captureSession stopRunning];
    //[self.bbitemStart setTitle:@"Start" forState:UIControlStateNormal];
    _captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
    [SVProgressHUD dismiss];
    //get back to AddNewProduct View
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
