//
//  ILTRepository.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/6/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTRepository.h"

@implementation ILTRepository

# pragma mark - save data from network 20 members

- (void)saveDataFromNetwork:(NSArray *)dictionary {
    NSArray *dataTags = [[NSArray alloc]initWithArray:dictionary];
    for (int i = 0; i <dataTags.count; i++) {
        NSDictionary *tag = [dataTags objectAtIndex:i];
    }
}
@end
