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

#warning для чего нужно это свойство я не особо понял. Если оно никем не используется, то удалите его
- (NSString *)urlForAuthentification {
    return [NSString stringWithFormat:AUTHENTIFICATION, kClientID, @"scope=likes+comments"];
}

#pragma mark - reguest data

- (void)recieveDataFromServer:(NSString *)urlServer tagForSearch:(NSString *)tag {
    if (urlServer == nil) {
        urlServer = [NSString stringWithFormat:TAGREQUEST, tag, [[NSUserDefaults standardUserDefaults]
                                                                 objectForKey:@"accessToken"]];
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
#warning используйте weakSelf внутри блоков вместо strong ссылки на self
        _nextPage = [NSString stringWithFormat:@"%@",[serializedData valueForKeyPath:@"pagination.next_url"]];
       [[NSUserDefaults standardUserDefaults] setObject:_nextPage
                                                 forKey:@"nextPage"];
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
    NSString *nextPage = [[NSUserDefaults standardUserDefaults]
                          objectForKey:@"nextPage"];
    if (nextPage != nil) {
        [self recieveDataFromServer:nextPage tagForSearch:nil];
    }
}

@end
