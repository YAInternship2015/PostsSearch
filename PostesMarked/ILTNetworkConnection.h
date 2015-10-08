//
//  ILTNetworkConnection.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/2/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ILTSendedDataDelegate.h"
#import "ILTRepository.h"

#warning у этого объекта получается слишком много ответственностей. Он и посты грузит, и юзера авторизирует. Необходимо разделить его на два объекта - один занимается авторизацией, второй - загрузкой постов. Токен пользователя можно хранить, например, в NSUserDefaults.
@interface ILTNetworkConnection : NSObject <ILTSendedDataDelegate>

#warning не стоит показывать наружу URL для следующей страницы. Для загрузки следующей страницы достаточно в интерфейсе показать метод вроде loadNextPage и все, без каких-либо деталей реализации
@property (nonatomic, strong) NSString *nextPage;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSURLConnection *tokenRequestConnection;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) ILTRepository *repository;
#warning по правилам именования в геттерах не используется префикс get. И в остальной части имени опечатка
- (NSString *) getURlForAuthintification;
#warning создавать NSURLRequest из NSString лучше в категории к NSURLRequest
- (NSURLRequest *) representRequest:(NSString *)url;
- (void)addDataFromNetwork:(NSData *)data;
#warning странный метод, название такое, будто это сеттер, но параметра нет
- (void)setToken;
- (void)requestTags:(NSString *)url tagForSearch:(NSString *)tag;

@end
