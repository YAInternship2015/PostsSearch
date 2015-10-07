//
//  ILTInstagramsPostes.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/7/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTInstagramsPostes.h"

@implementation ILTInstagramsPostes

- (UIImage *)getImage {
    return  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.pathPicture]]];
}

@end
