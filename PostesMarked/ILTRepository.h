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

@property (nonatomic, weak) id<ILTSendedDataDelegate> delegate;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
- (void)saveDataFromNetwork:(NSArray *)array;
- (NSArray *)getCoreDataItems;
- (void)deleteItem:(NSIndexPath *)index;
- (NSFetchedResultsController *)getFetchedResultsController;
- (void)nextLoading;

@end
