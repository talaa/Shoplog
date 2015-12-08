//
//  Category+CoreDataProperties.h
//  ttttt
//
//  Created by Mena Bebawy on 12/8/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface Category (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *catName;
@property (nullable, nonatomic, retain) Shoplog *categoryDetails;

@end

NS_ASSUME_NONNULL_END
