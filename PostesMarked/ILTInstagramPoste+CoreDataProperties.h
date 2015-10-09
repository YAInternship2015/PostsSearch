//
//  ILTInstagramsPostes+CoreDataProperties.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/9/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ILTInstagramPoste.h"

NS_ASSUME_NONNULL_BEGIN

@interface ILTInstagramPoste (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *commentText;
@property (nullable, nonatomic, retain) NSString *imageURLString;
@property (nullable, nonatomic, retain) NSString *postID;

@end

NS_ASSUME_NONNULL_END
