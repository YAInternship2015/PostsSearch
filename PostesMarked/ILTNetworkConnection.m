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

@property (nonatomic, retain) NSString *urlForAuthentification;
@property (nonatomic, weak) NSString *nextPage;
@property (nonatomic, strong) ILTAccessTokenManager *manager;

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
        urlServer = [NSString stringWithFormat:TAGREQUEST, tag, [_manager fetchaccessToken]];
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

#warning так и не увидел weakSelf здесь. Проблема в том, что когда Вы пишете в блоке _nextPage - это по сути обращение к self.nextPage, то есть такое обращение увеличивает счетчик ссылок на объект self на 1. Так как блок захватывает контекст во время своего объявления, то уже после объявления блока значение этого счетчика увеличится. Вот что необходимо было написать:
    
//       __weak typeof(self) weakSelf = self;
   [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//       NSDictionary *serializedData = (NSDictionary *)responseObject;
//       weakSelf.nextPage = [NSString stringWithFormat:@"%@",[serializedData valueForKeyPath:@"pagination.next_url"]];
//       [weakSelf.manager setupNextPage:weakSelf.nextPage];
//       NSString *newNextMaxId = [NSString stringWithFormat:@"%@",[serializedData valueForKeyPath:@"pagination.next_max_id"]];
//       if (![newNextMaxId isEqualToString:[weakSelf.manager fetchNextMaxId]]) {
//           NSArray *data = [serializedData objectForKey:@"data"];
//           [weakSelf.repository saveDataFromNetwork:data];
//           [weakSelf.manager setupNextMaxId: newNextMaxId];
//       }
       
       
        NSDictionary *serializedData = (NSDictionary *)responseObject;
        _nextPage = [NSString stringWithFormat:@"%@",[serializedData valueForKeyPath:@"pagination.next_url"]];
       [_manager setupNextPage:_nextPage];
        NSString *newNextMaxId = [NSString stringWithFormat:@"%@",[serializedData valueForKeyPath:@"pagination.next_max_id"]];
            if (![newNextMaxId isEqualToString:[_manager fetchNextMaxId]]) {
                NSArray *data = [serializedData objectForKey:@"data"];
                [_repository saveDataFromNetwork:data];
                [_manager setupNextMaxId: newNextMaxId];
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
    NSString *nextPage = [_manager fetchNextPage];
    if (nextPage != nil) {
        [self recieveDataFromServer:nextPage tagForSearch:nil];
    }
}

@end
