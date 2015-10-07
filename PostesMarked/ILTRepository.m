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

@end

@implementation ILTRepository

- (id)init {
    self = [super init];
    if (self) {
        _context = [NSManagedObjectContext MR_context];
        _fetchedResultsController = [ILTInstagramsPostes MR_fetchAllSortedBy:@"id" ascending:YES withPredicate:nil groupBy:nil delegate:self];
    }
    return self;
}

# pragma mark - save data from network 20 members

- (void)saveDataFromNetwork:(NSArray *)dictionary {
    NSArray *dataTags = [[NSArray alloc]initWithArray:dictionary];
    for (int i = 0; i < dataTags.count; i ++) {
        ILTInstagramsPostes *itemExist = nil;
        NSDictionary *tag = [dataTags objectAtIndex:i];
        itemExist = [ILTInstagramsPostes MR_findFirstByAttribute:@"id" withValue:[tag objectForKey:@"id"]];
        ILTInstagramsPostes *item = nil;
        if (itemExist == nil) {
            item = [ILTInstagramsPostes MR_createEntityInContext:_context];
        }
        else {
            item = itemExist;
        }
        item.id = [tag objectForKey:@"id"];
        NSDictionary *captionText = [tag objectForKey:@"caption"];
        item.comentText = [captionText objectForKey:@"text"];
        NSDictionary *images = [tag objectForKey:@"images"];
        NSDictionary *image = [images objectForKey:@"low_resolution"];
        item.pathPicture = [image objectForKey:@"url"];
        item.sizeHeight = [image objectForKey:@"height"];
        item.sizeWidtch = [image objectForKey:@"width"];
        [_context MR_saveToPersistentStoreAndWait];
    }
}

- (NSArray *)getCoreDataItems {
    return [ILTInstagramsPostes MR_findAll];
}
#pragma mark - delete item from repository

- (void)deleteItem:(NSIndexPath *)index {
    ILTInstagramsPostes *item = [_fetchedResultsController objectAtIndexPath:index];
    [item MR_deleteEntity];
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
}


- (void)nextLoading {
    [self.delegate requestTags:[self.delegate nextPage] tagForSearch:nil];
}

- (NSFetchedResultsController *)getFetchedResultsController {
    return _fetchedResultsController;
}

@end
