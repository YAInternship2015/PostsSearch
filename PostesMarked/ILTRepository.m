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

#warning контекст для создания/изменения/удаления моделей лучше создавать новый при каждой необходимости, создавать его как дочерний от MR_defaultContext. В таком случае в этом дочернем контексте всегда будут те же данные, что и в дефолтном. Иначе будет необходимо дополнительно реализовывать "подхватывание" изменений из дефолтного контекста и их применение в дочернем
@property (nonatomic, strong) NSManagedObjectContext *context;
#warning массив itemsOfTag не нужен. Данные получать необходимо напрямую из выборки NSFetchedResultsController'а
@property (nonatomic, strong) NSMutableArray *itemsOfTag;

@end

@implementation ILTRepository

#pragma mark - init item

- (id)init {
    self = [super init];
    if (self) {
        _context = [NSManagedObjectContext MR_context];
        _fetchedResultsController = [ILTInstagramsPostes MR_fetchAllSortedBy:@"id" ascending:YES withPredicate:nil groupBy:nil delegate:self];
        _itemsOfTag = [[NSMutableArray alloc]initWithArray:[ILTInstagramsPostes MR_findAll]];
    }
    return self;
}

#pragma mark - save data from network 20 members

#warning странно, что в параметр с именем dictionary приходит объект класса NSArray
- (void)saveDataFromNetwork:(NSArray *)dictionary {
#warning посмотрев на название переменной dataTags кажется, что там лежат теги, но там посты. Переименуйте переменную
    NSArray *dataTags = [[NSArray alloc]initWithArray:dictionary];
#warning здесь лучше использовать цикл for-each, перебирая NSDictionary
    for (int i = 0; i < dataTags.count; i++) {
        ILTInstagramsPostes *itemExist = nil;
#warning здесь не тег, а instagramPostData
        NSDictionary *tag = [dataTags objectAtIndex:i];
        itemExist = [ILTInstagramsPostes MR_findFirstByAttribute:@"id" withValue:[tag objectForKey:@"id"]];
        ILTInstagramsPostes *item = nil;
        if (itemExist == nil) {
            item = [ILTInstagramsPostes MR_createEntityInContext:_context];
            [_itemsOfTag addObject:item];
        }
        else {
            item = itemExist;
        }
#warning заполнение поста из NSDictionary надо вынести в категорию к модели в отдельный метод
        item.id = [tag objectForKey:@"id"];
#warning чтобы добраться до текста в один вызов, достаточно выполнить [tag valueForKeyPath:@"caption.text"]. По аналогии следует поступить с картинкой
        NSDictionary *captionText = [tag objectForKey:@"caption"];
        item.comentText = [captionText objectForKey:@"text"];
        NSDictionary *images = [tag objectForKey:@"images"];
        NSDictionary *image = [images objectForKey:@"low_resolution"];
        item.pathPicture = [image objectForKey:@"url"];
        item.sizeHeight = [image objectForKey:@"height"];
        item.sizeWidtch = [image objectForKey:@"width"];
#warning контекст стоит сохранять один раз уже после цикла, а не на каждой итерации
        [_context MR_saveToPersistentStoreAndWait];
    }
}

#pragma mark - get items of repository 

- (NSMutableArray *)getCoreDataItems {
    return _itemsOfTag;
}

#pragma mark - delete item from repository

- (void)deleteItem:(NSIndexPath *)index {
    [_itemsOfTag removeObjectAtIndex:[index row]];
    ILTInstagramsPostes *item = [_fetchedResultsController objectAtIndexPath:index];
    [item MR_deleteEntityInContext:_context];
    [_context MR_saveToPersistentStoreWithCompletion:nil ];
}

#pragma mark - loading next part of data

- (void)nextLoading {
#warning зачем такой сложный вызов? Лучше также вызвать у делегата метод loadNextPage вообще без параметров, раз вся нужная информация уже есть у него
    [self.delegate requestTags:[self.delegate nextPage] tagForSearch:nil];
}

#pragma mark - get fetched results controller 

- (NSFetchedResultsController *)getFetchedResultsController {
    return _fetchedResultsController;
}

@end
