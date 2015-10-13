//
//  ILTRepository.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/6/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTRepository.h"
#import <CoreData/CoreData.h>
#import "MagicalRecord/MagicalRecord.h"

@interface ILTRepository ()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ILTRepository

#pragma mark - init item

- (id)init {
    self = [super init];
    if (self) {
        _context = [NSManagedObjectContext MR_context];
       _fetchedResultsController = [ILTInstagramPoste MR_fetchAllSortedBy:@"postID" ascending:YES withPredicate:nil groupBy:nil delegate:nil];
    }
    return self;
}

#pragma mark - save data from network 20 members

- (void)saveDataFromNetwork:(NSArray *)array {
    NSArray *dataPosts = [[NSArray alloc]initWithArray:array];
    for (NSDictionary *itemPost in dataPosts) {
        ILTInstagramPoste *itemExist = nil;
        itemExist = [ILTInstagramPoste MR_findFirstByAttribute:@"postID" withValue:[itemPost objectForKey:@"id"]];
        ILTInstagramPoste *item = nil;
        if (itemExist == nil) {
            item = [ILTInstagramPoste MR_createEntityInContext:_context];
        }
        else {
            item = itemExist;
        }
        [item updateWithDataDictionary:itemPost];
    }
    [_context MR_saveToPersistentStoreAndWait];
}

#pragma mark - get item of repository 

- (ILTInstagramPoste *)itemAtIndexPath:(NSIndexPath *)index {
    return [_fetchedResultsController objectAtIndexPath:index];
}

#pragma mark - delete item from repository

- (void)deleteItemAtIndexPath:(NSIndexPath *)index {
    ILTInstagramPoste *item = [_fetchedResultsController objectAtIndexPath:index];
    [item MR_deleteEntityInContext:_context];
    [_context MR_saveToPersistentStoreAndWait];
}

#pragma mark - loading next part of data

 - (void)loadNextPage {
    [self.delegate loadNextPage];
}

#pragma mark - get count members in repository

- (NSUInteger)countOfItems {
    return  [[ILTInstagramPoste MR_findAll]count];
}

#pragma  mark - set delegate 

- (void)setFetchedResultsControllerDelegate:(id <NSFetchedResultsControllerDelegate>) delegateTable {
    [_fetchedResultsController setDelegate:delegateTable];
}

@end
