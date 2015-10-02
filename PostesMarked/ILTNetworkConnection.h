//
//  ILTNetworkConnection.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/2/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILTNetworkConnection : NSObject

- (NSString *) getURlForAuthintification;
- (NSURLRequest *) representRequest:(NSString *)url;

@end
