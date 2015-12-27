//
//  DataParsing.h
//  ttttt
//
//  Created by Mena Bebawy on 12/2/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataTransferObject.h"

@interface DataParsing : NSObject

+ (void)dataTransferObjectDeAllocat;
+ (NSArray *)fetchEntitesArray:(NSString*)entityName;
+ (NSInteger)returnFetchEntitiesArrayCounter:(NSString*)entityName;
+ (bool)isProductExistsOnCDbyImageURL:(NSString*)imageURL ByEntity:(NSString*)entityName;
+ (NSMutableArray*)fetchProductsbyCategory;
+ (NSMutableArray *)fetchProductbyImageData:(NSData*)imageData AndEntityName:(NSString*)entityName;
+ (void)removeEntityRecordbyItemId:(NSString*)itemID;
+ (void)removeCategoryInCaseOfNoItems:(NSString*)catName;
+ (void)saveContext;
+ (BOOL)ifCategoryNameExistOnEntit:(NSString*)entityName CategoryName:(NSString*)catname;
+ (void)deleteProductByID:(NSString*)Id ByEntityName:(NSString*)entityName;
+ (NSString *)createRandomId;
+ (void)editProductById:(NSString*)proID AndEntityName:(NSString*)entityName;
+ (BOOL)dontShowIntroAgain;
+ (void)setIntroValueToNO;
+ (void)setIntroValueToYES;


@end
