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
@property (nonatomic, strong) NSMutableArray *itemsOfTag;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ILTRepository

#pragma mark - init item

- (id)init {
    self = [super init];
    if (self) {
        _context = [NSManagedObjectContext MR_context];
        _fetchedResultsController = [ILTInstagramPoste MR_fetchAllSortedBy:@"postID" ascending:YES withPredicate:nil groupBy:nil delegate:self];
        _itemsOfTag = [[NSMutableArray alloc]initWithArray:[ILTInstagramPoste MR_findAll]];
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
            [_itemsOfTag addObject:item];
        }
        else {
            item = itemExist;
        }
        [item fillData:itemPost];
    }
    [_context MR_saveToPersistentStoreAndWait];
}

#pragma mark - get items of repository 

- (NSMutableArray *)numberOfItems {
    return _itemsOfTag;
}

#pragma mark - delete item from repository

- (void)deleteItemAtIndexPath:(NSIndexPath *)index {
    [_itemsOfTag removeObjectAtIndex:[index row]];
    ILTInstagramPoste *item = [_fetchedResultsController objectAtIndexPath:index];
    [item MR_deleteEntityInContext:_context];
    [_context MR_saveToPersistentStoreWithCompletion:nil ];
}

#pragma mark - loading next part of data

/*- (void)nextLoading {
#warning зачем такой сложный вызов? Лучше также вызвать у делегата метод loadNextPage вообще без параметров, раз вся нужная информация уже есть у него
    [self.delegate requestTags:[self.delegate nextPage] tagForSearch:nil];
}*/

#pragma mark - get fetched results controller 

- (NSFetchedResultsController *)getFetchedResultsController {
    return _fetchedResultsController;
}

@end
