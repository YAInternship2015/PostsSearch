//
//  NSURLRequest+ILTRepresentURLRequest.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/10/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "NSURLRequest+ILTNetworkConnection.h"

@implementation NSURLRequest (ILTNetworkConnection)

#pragma mark - present request

+ (NSURLRequest *)representRequest:(NSString *)url {
    return [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
}
@end
