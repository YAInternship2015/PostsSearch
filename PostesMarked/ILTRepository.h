//
//  ILTRepository.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/6/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILTInstagramsPostes.h"

@interface ILTRepository : NSObject
- (void)saveDataFromNetwork: (NSArray *)array;
- (NSArray *)getCoreDataItems;
- (void)deleteItem: (ILTInstagramsPostes *)item;
- (void)addItem: (ILTInstagramsPostes *) item;
- (BOOL)searchItem: (ILTInstagramsPostes *)item;
- (ILTInstagramsPostes *)getItem: (int)index;
@end
