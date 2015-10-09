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
#import "Defines.h"



@interface ILTNetworkConnection () 

@property (nonatomic, retain) NSString *urlForAuthentification;
//@property (nonatomic, strong) NSDictionary *serializedData;
@property (nonatomic, strong) NSString *nextMaxId;
@property (nonatomic, strong) NSString *nextPage;

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

- (NSString *)urlForAuthentification {
    return [NSString stringWithFormat:AUTHENTIFICATION, kClientID, @"scope=likes+comments"];
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
#warning этот метод надо переименовать, вообще неясно, чем он занимается
- (void)requestTags:(NSString *)url tagForSearch:(NSString *) tag {
    if (url == nil) {
        url = [NSString stringWithFormat:TAGREQUEST, tag, _accessToken];
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
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
   [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *serializedData = (NSDictionary *)responseObject;
#warning используя ivar, такой как _nextPage, внутри блока Вы создаете так называемый retain cycle, в гугле можно почитать, что это. Для обращения к свойствам объекта, да и вообще к self, внутри блока необходимо использовать weak ссылку на объект, что это также легко гуглится
        _nextPage = [NSString stringWithFormat:@"%@",[serializedData valueForKeyPath:@"pagination.next_url"]];
            NSString *newNextMaxId = [NSString stringWithFormat:@"%@",[serializedData valueForKeyPath:@"pagination.next_max_id"]];
            if (![newNextMaxId isEqualToString:_nextMaxId]) {
                NSArray *data = [serializedData objectForKey:@"data"];
                [_repository saveDataFromNetwork:data];
                _nextMaxId = newNextMaxId;
            }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                            message:NSLocalizedString([error localizedDescription], nil)
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    [operation start];
}

#pragma mark - load next page

- (void)loadNextPage {
    [self requestTags:_nextPage tagForSearch:nil];
}

@end
