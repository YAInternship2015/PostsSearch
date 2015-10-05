//
//  ILTNetworkConnection.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/2/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTNetworkConnection.h"
#import "Defines.h"
#import "ILTLoginWebViewController.h"

@interface ILTNetworkConnection ()


@property (nonatomic, strong) NSString *nextPage;
@property (nonatomic, retain) NSString *getURlForAuthintification;

@end

@implementation ILTNetworkConnection

- (NSString *)getURlForAuthintification {
    return [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&display=touch&%@&redirect_uri=http://localhost&response_type=code", kClientID, @"scope=likes+comments"];
}

- (NSURLRequest *)representRequest:(NSString *)url {
    return [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
}


- (void)addDataFromNetwork:(NSData *)addData {
    [_data appendData:addData];
}

- (void)setToken {
    NSError *jsonError = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:&jsonError];
    if(jsonData && [NSJSONSerialization isValidJSONObject:jsonData])
    {
        _accessToken = [jsonData objectForKey:@"access_token"];
    }
}

- (void)requestTags:(NSString *)url tagForSearch:(NSString *) tag {
    if (url == nil) {
        url = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?access_token=%@",tag,_accessToken];
    }
}
@end
