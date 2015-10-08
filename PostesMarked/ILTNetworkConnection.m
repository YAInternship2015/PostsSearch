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
#import "AFNetworking.h"



@interface ILTNetworkConnection () 

@property (nonatomic, retain) NSString *getURlForAuthintification;
@property (nonatomic, strong) NSDictionary *recivedData;
@property (nonatomic, strong) NSString *nextMaxId;

@end

@implementation ILTNetworkConnection

#pragma mark - init item

- (id)init {
    self = [super init];
    if (self) {
        _repository = [[ILTRepository alloc]init];
        _repository.delegate = self;
    }
    return self;
}

#pragma mark - get url for authentification

- (NSString *)getURlForAuthintification {
    return [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&display=touch&%@&redirect_uri=http://localhost&response_type=code", kClientID, @"scope=likes+comments"];
}

#pragma mark - present request

- (NSURLRequest *)representRequest:(NSString *)url {
    return [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
}

#pragma mark - add data

- (void)addDataFromNetwork:(NSData *)addData {
    [_data appendData:addData];
}

#pragma mark - set token for next request

- (void)setToken {
    NSError *jsonError = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:&jsonError];
    if(jsonData && [NSJSONSerialization isValidJSONObject:jsonData])
    {
        _accessToken = [jsonData objectForKey:@"access_token"];
    }
}

#pragma mark - reguest data
- (void)requestTags:(NSString *)url tagForSearch:(NSString *) tag {
    if (url == nil) {
        url = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?access_token=%@",tag,_accessToken];
        _nextPage = nil;
    }
    NSURL *urlRequest;
    if (_nextPage == nil) {
        urlRequest = [NSURL URLWithString:url];
    }
    else {
        urlRequest = [NSURL URLWithString:_nextPage];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:urlRequest];
    AFHTTPRequestOperation *manager = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
   [manager setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        _recivedData = (NSDictionary *)responseObject;
       int code =[[[_recivedData objectForKey:@"meta"] objectForKey:@"code"]intValue];
        if (code == 200) {
        _nextPage = [NSString stringWithFormat:@"%@",[[_recivedData objectForKey:@"pagination"] objectForKey:@"next_url"]];
            NSString *newNextMaxId = [NSString stringWithFormat:@"%@",[[_recivedData objectForKey:@"pagination"] objectForKey:@"next_max_id"]];
            if (![newNextMaxId isEqualToString:_nextMaxId]) {
                NSArray *data = [_recivedData objectForKey:@"data"];
                [_repository saveDataFromNetwork:data];
                _nextMaxId = newNextMaxId;
            }
        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    [manager start];
}

@end
