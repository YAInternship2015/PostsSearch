//
//  ILTInstagramsPostes.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/7/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTInstagramPoste.h"


@interface  ILTInstagramPoste ()

@end

@implementation ILTInstagramPoste

#pragma mark - fill data

- (void)updateWithDataDictionary:(NSDictionary *)dictionary {
    self.postID = [dictionary objectForKey:@"id"];
    self.commentText = [dictionary valueForKeyPath:@"caption.text"];
    self.imageURLString = [dictionary valueForKeyPath:@"images.low_resolution.url"];
}

#pragma mark - return Url images

#warning а зачем этот метод нужен?))
- (NSString *) retrurnUrlString {
    return self.imageURLString;
}

@end
