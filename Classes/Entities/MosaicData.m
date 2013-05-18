//
//  MosaicData.m
//  MosaicCollectionView
//
//  Created by Ezequiel A Becerra on 2/17/13.
//  Copyright (c) 2013 Betzerra. All rights reserved.
//

#import "MosaicData.h"

@implementation MosaicData
@synthesize title, imageFilename,maintext,url;

-(id)initWithDictionary:(NSDictionary *)aDict{
    self = [self init];
    if (self){
        
        self.imageFilename = [aDict objectForKey:@"imagelink"];
        self.title = [aDict objectForKey:@"tweettext"];
        self.url=[aDict objectForKey:@"tweetlink"];
        self.firstTimeShown = YES;
    }
    return self;
}


-(NSString *)description{
    NSString *retVal = [NSString stringWithFormat:@"%@ %@", [super description], self.title];
    return retVal;
}

@end
