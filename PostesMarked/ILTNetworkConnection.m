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
#warning опечатка в имени, да и само имя больше подходит для NSData, а не NSDictionary
@property (nonatomic, strong) NSDictionary *recivedData;
@property (nonatomic, strong) NSString *nextMaxId;

@end

@implementation ILTNetworkConnection

#pragma mark - init item

- (id)init {
    self = [super init];
    if (self) {
#warning по идее репозиторий должен внутри себя хранить такой api client, который умеет грузить посты, а не наоборот. Контроллер говорит repository, что пора грузить пачку постов, и repository внутри себя говорит api client'у, чтобы тот грузил посты
        _repository = [[ILTRepository alloc]init];
        _repository.delegate = self;
    }
    return self;
}

#pragma mark - get url for authentification

- (NSString *)getURlForAuthintification {
#warning все урлы в данном классе надо вынести в константы
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
#warning этот метод надо переименовать, вообще неясно, чем он занимается
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
#warning какой же это manager, это operation
    AFHTTPRequestOperation *manager = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
   [manager setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
#warning неясно, зачем хранить полученные данные в свойстве объекта? Они же используются только внутри данного блока, значит можно их хранить в обычной переменной
        _recivedData = (NSDictionary *)responseObject;
#warning код ответа сервера можно не проверять, внутри AFNetworking он уже обрабатывается. В successBlock программа попадает только при успешных кодах
       int code =[[[_recivedData objectForKey:@"meta"] objectForKey:@"code"]intValue];
        if (code == 200) {
#warning внутри NSDictionary с вложенностью легко получать вложенные значения через метод valueForKeyPath:, так будет правильнее
#warning используя ivar, такой как _nextPage, внутри блока Вы создаете так называемый retain cycle, в гугле можно почитать, что это. Для обращения к свойствам объекта, да и вообще к self, внутри блока необходимо использовать weak ссылку на объект, что это также легко гуглится
        _nextPage = [NSString stringWithFormat:@"%@",[[_recivedData objectForKey:@"pagination"] objectForKey:@"next_url"]];
            NSString *newNextMaxId = [NSString stringWithFormat:@"%@",[[_recivedData objectForKey:@"pagination"] objectForKey:@"next_max_id"]];
            if (![newNextMaxId isEqualToString:_nextMaxId]) {
                NSArray *data = [_recivedData objectForKey:@"data"];
                [_repository saveDataFromNetwork:data];
                _nextMaxId = newNextMaxId;
            }
        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
#warning какой тут "Weather"?)) Текст ошибки можно взять из обхекта NSError
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
