//
//  ILTNetworkConnection.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/2/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTNetworkConnection.h"
#import "ILTDefines.h"
#import "ILTLoginWebViewController.h"
#import "AFNetworking.h"
#import "ILTAccessTokenManager.h"

@interface ILTNetworkConnection () 

@property (nonatomic, strong) NSString *nextPage;
@property (nonatomic, strong) ILTAccessTokenManager *manager;
@property (nonatomic, strong) NSString *nextMaxId;

@end

@implementation ILTNetworkConnection

#pragma mark - init item

- (id)init {
    self = [super init];
    if (self) {
        _repository = [[ILTRepository alloc]init];
        _repository.delegate = self;
        _manager = [[ILTAccessTokenManager alloc]init];
    }
    return self;
}

#pragma mark - reguest data

- (void)recieveDataFromServer:(NSString *)urlServer tagForSearch:(NSString *)tag {
    if (urlServer == nil) {
        urlServer = [NSString stringWithFormat:TAGREQUEST, tag, [_manager accessToken]];
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
    __weak typeof(self) weakSelf = self;
   [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {      NSDictionary *serializedData = (NSDictionary *)responseObject;
       weakSelf.nextPage = [NSString stringWithFormat:@"%@",[serializedData valueForKeyPath:@"pagination.next_url"]];
      NSString *newNextMaxId = [NSString stringWithFormat:@"%@",[serializedData valueForKeyPath:@"pagination.next_max_id"]];
       if (![newNextMaxId isEqualToString:_nextMaxId]) {
          NSArray *data = [serializedData objectForKey:@"data"];
          [weakSelf.repository saveDataFromNetwork:data];
          weakSelf.nextMaxId = newNextMaxId;
       }
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                            message:NSLocalizedString([error localizedDescription], nil)
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"Ok", nil)
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    [operation start];
}

#pragma mark - load next page

- (void)loadNextPage {
    NSString *nextPage = _nextPage;
    if (nextPage != nil) {
        [self recieveDataFromServer:nextPage tagForSearch:nil];
    }
}

@end
