//
//  ILTAccessTokenManager.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/12/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILTAccessTokenManager : NSObject

- (void)setupNextPage:(NSString *)nextPage;
- (void)setupAccessToken:(NSString *)accessToken;
- (NSString *)fetchNextPage;
- (NSString *)fetchaccessToken;
- (NSString *)fetchNextMaxId;
- (void)setupNextMaxId:(NSString *)nextMaxId;

@end
