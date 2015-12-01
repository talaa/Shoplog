//
//  DataTransferObject.m
//  ttttt
//
//  Created by Mena Bebawy on 12/1/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import "DataTransferObject.h"

@implementation DataTransferObject
static DataTransferObject *instance = nil;

+(DataTransferObject *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [DataTransferObject new];
        }
    }
    return instance;
}


@end
