//
//  ILTInstagramsPostes.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/7/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ILTInstagramsPostes : NSManagedObject

- (UIImage *)getImage;

@end

NS_ASSUME_NONNULL_END

#import "ILTInstagramsPostes+CoreDataProperties.h"
