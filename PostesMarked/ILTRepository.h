//
//  ILTRepository.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/6/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILTInstagramsPostes.h"
#import "ILTSendedDataDelegate.h"

@interface ILTRepository : NSObject <NSFetchedResultsControllerDelegate>

#warning по сути данный delegate является источником данных, потому я бы его назвал dataProvider
@property (nonatomic, weak) id<ILTSendedDataDelegate> delegate;
#warning fetchedResultsController должен быть только в *.m
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (void)saveDataFromNetwork:(NSArray *)array;

#warning здесь вместо метода getCoreDataItems должен быть все тот же интерфейс numberOfItems и itemAtIndex или вроде того
- (NSArray *)getCoreDataItems;
#warning deleteItemAtIndexPath:
- (void)deleteItem:(NSIndexPath *)index;

#warning этот метод не нужен
- (NSFetchedResultsController *)getFetchedResultsController;
#warning loadNextPage
- (void)nextLoading;

@end
