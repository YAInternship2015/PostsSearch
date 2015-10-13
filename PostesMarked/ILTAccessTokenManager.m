//
//  ILTAccessTokenManager.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/12/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTAccessTokenManager.h"

@implementation ILTAccessTokenManager



#pragma mark - setup access token 

- (void)setAccessToken:(NSString *)accessToken {
[[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"accessToken"];
}


#pragma mark - get accessToken

- (NSString *)accessToken {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"];
}



@end
