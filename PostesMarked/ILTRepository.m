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
        if (itemExist == nil) {
            ILTInstagramsPostes *item = [ILTInstagramsPostes MR_createEntityInContext:_context];
            item.id = [tag objectForKey:@"id"];
            NSDictionary *captionText = [tag objectForKey:@"caption"];
            item.comentText = [captionText objectForKey:@"text"];
            NSDictionary *images = [tag objectForKey:@"images"];
            NSDictionary *image = [images objectForKey:@"low_resolution"];
            item.pathPicture = [image objectForKey:@"url"];
            item.sizeHeight = [image objectForKey:@"height"];
            item.sizeWidtch = [image objectForKey:@"width"];
        }
    }
}

- (NSArray *)getCoreDataItems {
    return [ILTInstagramsPostes MR_findAll];
}
- (void)deleteItem: (ILTInstagramsPostes *)item {
    
}
- (void)addItem: (ILTInstagramsPostes *) item {
    
}
- (BOOL)searchItem: (ILTInstagramsPostes *)item {
    return YES;
    
}
/*- (ILTInstagramsPostes *)getItem: (int)index {

}*/
@end
