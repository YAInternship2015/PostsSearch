//
//  ILTInstagramsPostes+CoreDataProperties.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/7/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ILTInstagramsPostes.h"

NS_ASSUME_NONNULL_BEGIN

#warning лучше ILTInstagramPost
@interface ILTInstagramsPostes (CoreDataProperties)

#warning commentText
@property (nullable, nonatomic, retain) NSString *comentText;
#warning имя переменной id конфликтует с типом данных id, лучше переименуйте свойсво на postID или что-то такое
@property (nullable, nonatomic, retain) NSString *id;
#warning лучше imageURLString
@property (nullable, nonatomic, retain) NSString *pathPicture;
#warning не нашел применения следующих двух свойств. Если они не нужны, то удалите их
@property (nullable, nonatomic, retain) NSNumber *sizeHeight;
@property (nullable, nonatomic, retain) NSNumber *sizeWidtch;

@end

NS_ASSUME_NONNULL_END
