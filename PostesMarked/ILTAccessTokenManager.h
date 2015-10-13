//
//  ILTAccessTokenManager.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/12/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning то, что появился ILTAccessTokenManager - это хорошо. Но что в нем делают nextPage и nextMaxId? Здесь должен быть только токен и все. nextPage и nextMaxId - это вещи ILTNetworkConnection

@interface ILTAccessTokenManager : NSObject

- (void)setupNextPage:(NSString *)nextPage;
#warning лучше просто setAccessToken:
- (void)setupAccessToken:(NSString *)accessToken;
- (NSString *)fetchNextPage;
#warning лучше просто accessToken
- (NSString *)fetchaccessToken;
- (NSString *)fetchNextMaxId;
- (void)setupNextMaxId:(NSString *)nextMaxId;

@end
