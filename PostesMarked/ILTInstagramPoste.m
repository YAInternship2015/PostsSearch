//
//  ILTInstagramsPostes.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/7/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTInstagramPoste.h"

@implementation ILTInstagramPoste

#pragma mark - get image

- (UIImage *)getImage {
    return  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageURLString]]];
}

#pragma mark - fill data

- (void)fillData:(NSDictionary *)dictionary {
    self.postID = [dictionary objectForKey:@"id"];
    self.commentText = [dictionary valueForKeyPath:@"caption.text"];
    self.imageURLString = [dictionary valueForKeyPath:@"images.low_resolution.url"];
}
@end
