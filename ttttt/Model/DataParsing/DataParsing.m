//
//  DataParsing.m
//  ttttt
//
//  Created by Mena Bebawy on 12/2/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import "DataParsing.h"
#import "AppDelegate.h"

@implementation DataParsing

+ (void)dataTransferObjectDeAllocat {
    DataTransferObject *dtObject = [DataTransferObject getInstance];
    dtObject.defcatqr = nil;
}

// Fetch Entities Array
+ (NSArray *)fetchEntitesArray:(NSString*)entityName {
    AppDelegate *app= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    [fetchRequest setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObjects:@"Shop",nil]];
    [fetchRequest setIncludesSubentities:YES];
    NSError *fetchError = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&fetchError];
    return result;
}

// Return EntitiesArray's elements number
+ (NSInteger)returnFetchEntitiesArrayCounter:(NSString*)entityName{
    NSArray *result = [self fetchEntitesArray:entityName];
    return (result.count)?result.count:0;
}

// Fetch by exact data by TYPE
+ (bool)isProductExistsOnCDbyImageData:(NSData*)imageData ByEntity:(NSString*)entityName{
    BOOL isExit = NO;
    NSArray *result = [self fetchEntitesArray:entityName];
    for (NSManagedObject *managedObject in result) {
        if ([[managedObject valueForKey:@"image"] isEqualToData:imageData]) {
            isExit = YES;
            break;
        }
    }
    return isExit;
}

// Fetch by exact data by Category
+ (NSMutableArray*)fetchProductsbyCategory{
    NSMutableArray *productsByCategoryMArray = [NSMutableArray new];
    NSMutableArray *sameProductsMArray = [NSMutableArray new];
    NSArray *shoplogObjectsArray = [self fetchEntitesArray:@"Shoplog"];
    NSArray *categoryObjectsArray = [self fetchEntitesArray:@"Category"];
    
    for (NSManagedObject *categoryManagedObject in categoryObjectsArray){
        for (NSManagedObject *shoplogManagedObject in shoplogObjectsArray){
            if ([[shoplogManagedObject valueForKey:@"categoryname"] isEqualToString:[categoryManagedObject valueForKey:@"catName"]]){
                [sameProductsMArray addObject:shoplogManagedObject];
            }
        }
        [productsByCategoryMArray addObject:sameProductsMArray];
    }
    return productsByCategoryMArray;
}

// Fetch Product by ImageData
+ (NSMutableArray *)fetchProductbyImageData:(NSData*)imageData AndEntityName:(NSString*)entityName{
    NSMutableArray *productByImageData = [NSMutableArray new];
    NSArray *shoplogObjectsArray = [self fetchEntitesArray:entityName];
    for (NSManagedObject *managedObject in shoplogObjectsArray){
        NSData *data = [managedObject valueForKey:@"image"];
        if([data isEqualToData:imageData]){
            [productByImageData addObject:managedObject];
            break;
        }
    }
    return productByImageData;
}

@end
