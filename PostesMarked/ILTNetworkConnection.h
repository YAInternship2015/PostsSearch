//
//  ILTNetworkConnection.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/2/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ILTRepository.h"
#import "ILTDataProviderDelegate.h"

#warning у этого объекта получается слишком много ответственностей. Он и посты грузит, и юзера авторизирует. Необходимо разделить его на два объекта - один занимается авторизацией, второй - загрузкой постов. Токен пользователя можно хранить, например, в NSUserDefaults.
@interface ILTNetworkConnection : NSObject <ILTDataProviderDelegate>

@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSURLConnection *tokenRequestConnection;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) ILTRepository *repository;
- (NSString *) urlForAuthentification;
- (void)saveDataFromNetwork:(NSData *)data;
- (void)saveToken;
- (void)recieveDataFromServer:(NSString *)urlServer tagForSearch:(NSString *)tag;
- (void)loadNextPage;

@end
