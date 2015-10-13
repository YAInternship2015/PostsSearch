//
//  ILTRepository.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/6/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILTInstagramPoste.h"
#import "ILTDataProviderDelegate.h"

@interface ILTRepository : NSObject

@property (nonatomic, weak) id<ILTDataProviderDelegate> delegate;
- (void)saveDataFromNetwork:(NSArray *)array;
- (NSUInteger)countOfItems;
- (ILTInstagramPoste *)itemAtIndexPath:(NSIndexPath *)index;
- (void)deleteItemAtIndexPath:(NSIndexPath *)index;
- (void)loadNextPage;
- (void)setFetchedResultsControllerDelegate:(id <NSFetchedResultsControllerDelegate>) delegateTable;

@end
