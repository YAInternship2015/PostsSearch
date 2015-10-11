//
//  NSURLRequest+ILTRepresentURLRequest.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/10/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (ILTNetworkConnection)

+ (NSURLRequest *)representRequest:(NSString *)url;

@end
