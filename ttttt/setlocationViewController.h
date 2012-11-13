//
//  setlocationViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 11/6/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Shoplog.h"

@interface setlocationViewController : UIViewController
@property (nonatomic,strong)NSManagedObjectContext *managedObjectcontext;
@property (nonatomic,strong) Shoplog *shoplog;
@property (nonatomic)double shoplocationlong;
@property (nonatomic)double shoplocationlat;
@property (weak, nonatomic) IBOutlet MKMapView *setlocationMap;
- (IBAction)saveShoplocation:(id)sender;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *lgpr;
- (IBAction)lgpraction:(id)sender;
@property (nonatomic) float longano;
@property (nonatomic) float latano;
@end
