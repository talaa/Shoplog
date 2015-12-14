//
//  DataParsing.m
//  ttttt
//
//  Created by Mena Bebawy on 12/2/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import "DataParsing.h"
#import "AppDelegate.h"
#import "Shoplog.h"

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
    
    if (shoplogObjectsArray.count >0){
        for (NSManagedObject *categoryManagedObject in categoryObjectsArray){
            for (NSManagedObject *shoplogManagedObject in shoplogObjectsArray){
                if ([[shoplogManagedObject valueForKey:@"categoryname"] isEqualToString:[categoryManagedObject valueForKey:@"catName"]]){
                    [sameProductsMArray addObject:shoplogManagedObject];
                }
            }
            [productsByCategoryMArray addObject:sameProductsMArray];
        }
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

// Remove Entity Record
+ (void)removeEntityRecordbyImageData:(NSData*)imageData AndEntityName:(NSString*)entityName{
    AppDelegate *app= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    
    // Fetching
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    
    // Execute Fetch Request
    NSError *fetchError = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&fetchError];
    
    for (Shoplog *shoplog in result){
        NSData *data = [shoplog valueForKey:@"image"];
        if ([data isEqualToData:imageData]){
            [context deleteObject:shoplog];
            break;
        }
    }
    [self saveContext];
}

// Save changed on Core data permenantly
+ (void)saveContext {
    AppDelegate *app= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    
    if (context != nil) {
        NSError *error = nil;
        if ([context hasChanges] && ![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

+ (BOOL)ifCategoryNameExistOnEntit:(NSString*)entityName CategoryName:(NSString*)catname{
    BOOL isExist = NO;
    NSArray *categoryArray = [self fetchEntitesArray:entityName];
    for (NSManagedObject *managedObject in categoryArray){
        if([[managedObject valueForKey:@"catName"] isEqualToString:catname]){
            isExist = YES;
            break;
        }
    }
    return isExist;
}


@end
