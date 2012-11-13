//
//  MyAnotation.h
//  ttttt
//
//  Created by Tamer Alaa on 11/6/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnotation : NSObject<MKAnnotation>{

    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}

@property (nonatomic,assign)CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic) float longano;
@property (nonatomic) float latano;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString*)t subtitle:(NSString*)s;

@end
