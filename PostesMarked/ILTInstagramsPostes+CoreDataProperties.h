//
//  ILTInstagramsPostes+CoreDataProperties.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/6/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ILTInstagramsPostes.h"

NS_ASSUME_NONNULL_BEGIN

@interface ILTInstagramsPostes (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *comentText;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *pathPicture;
@property (nullable, nonatomic, retain) NSNumber *sizeHeight;
@property (nullable, nonatomic, retain) NSNumber *sizeWidtch;

@end

NS_ASSUME_NONNULL_END
