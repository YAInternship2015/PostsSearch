//
//  ILTAccessTokenManager.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/12/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILTAccessTokenManager : NSObject

- (void)setAccessToken:(NSString *)accessToken;
- (NSString *)accessToken;


@end
