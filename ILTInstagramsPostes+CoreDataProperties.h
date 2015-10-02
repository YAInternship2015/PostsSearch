//
//  ILTInstagramsPostes+CoreDataProperties.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/2/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ILTInstagramsPostes.h"

NS_ASSUME_NONNULL_BEGIN

@interface ILTInstagramsPostes (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *comentText;
@property (nonatomic) int64_t id;
@property (nullable, nonatomic, retain) NSString *pathPicture;
@property (nonatomic) int32_t sizeHeight;
@property (nonatomic) int32_t sizeWidtch;

@end

NS_ASSUME_NONNULL_END
