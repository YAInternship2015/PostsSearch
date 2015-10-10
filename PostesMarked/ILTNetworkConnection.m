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
@property (nonatomic, strong) NSString *nextMaxId;
@property (nonatomic, weak) NSString *nextPage;

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

#pragma mark - add data

- (void)saveDataFromNetwork:(NSData *)addData {
    [_data appendData:addData];
}

#pragma mark - set token for next request

- (void)saveToken {
    NSError *jsonError = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:&jsonError];
    if(jsonData && [NSJSONSerialization isValidJSONObject:jsonData])
    {
        _accessToken = [jsonData objectForKey:@"access_token"];
    }
}

#pragma mark - reguest data

- (void)recieveDataFromServer:(NSString *)urlServer tagForSearch:(NSString *)tag {
    if (urlServer == nil) {
        urlServer = [NSString stringWithFormat:TAGREQUEST, tag, _accessToken];
        _nextPage = nil;
    }
    NSURL *urlRequest;
    if (_nextPage == nil) {
        urlRequest = [NSURL URLWithString:urlServer];
    }
    else {
        urlRequest = [NSURL URLWithString:_nextPage];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:urlRequest];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
   [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *serializedData = (NSDictionary *)responseObject;
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
    [self recieveDataFromServer:_nextPage tagForSearch:nil];
}

@end
