//
//  ExtendedManagedObject.h
//  ttttt
//
//  Created by Tamer Alaa on 11/2/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ExtendedManagedObject : NSManagedObject{
    BOOL traversed;
}

@property (nonatomic, assign) BOOL traversed;

- (NSDictionary*) toDictionary;
- (void) populateFromDictionary:(NSDictionary*)dict;
+ (ExtendedManagedObject*) createManagedObjectFromDictionary:(NSDictionary*)dict
                                                   inContext:(NSManagedObjectContext*)context;


@end
