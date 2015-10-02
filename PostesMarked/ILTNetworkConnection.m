//
//  ILTNetworkConnection.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/2/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTNetworkConnection.h"
#import "Defines.h"

@interface ILTNetworkConnection ()

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *nextPage;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSURLConnection *tokenRequestConnection;
//@property (nonatomic, retain) NSString *getURlForAuthintification;

@end

@implementation ILTNetworkConnection

- (NSString *) getURlForAuthintification {
    return [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&display=touch&%@&redirect_uri=http://localhost&response_type=code", kClientID, @"scope=basic"];
}
- (NSURLRequest *) representRequest:(NSString *)url {
    return [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
}
@end
