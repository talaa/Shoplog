//
//  MyAnotation.m
//  ttttt
//
//  Created by Tamer Alaa on 11/6/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "MyAnotation.h"

@implementation MyAnotation
@synthesize coordinate,title,subtitle;
/*-(id)init{
    //CLLocationCoordinate2D location;
    //location.latitude=0;
    //location.longitude=0;
    //return [self initWithCoordinate:coordinate title:nil subtitle:nil];


}
*/
-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t subtitle:(NSString *)st{
    self=[super init];
    coordinate=c;
    title=t;
    subtitle=st;
    //title=[t retain];
    //subtitle=[st retain];
    return self;
}


@end
