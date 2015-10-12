//
//  ILTAccessTokenManager.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/12/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTAccessTokenManager.h"

@implementation ILTAccessTokenManager

#pragma mark - setup next page 

- (void)setupNextPage:(NSString *)nextPage {
    [[NSUserDefaults standardUserDefaults] setObject:nextPage forKey:@"nextPage"];
}

#pragma mark - setup access token 

- (void)setupAccessToken:(NSString *)accessToken {
[[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"accessToken"];
}

#pragma mark - get next page

- (NSString *)fetchNextPage {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"nextPage"];
}

#pragma mark - get accessToken

- (NSString *)fetchaccessToken {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"];
}

#pragma makr - get next max id

- (NSString *)fetchNextMaxId {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"nextMaxId"];
}

#pragma mark - setup next max id 

- (void)setupNextMaxId:(NSString *)nextMaxId {
    [[NSUserDefaults standardUserDefaults] setObject:nextMaxId forKey:@"nextMaxId"];
}

@end
