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

@interface ILTNetworkConnection : NSObject <ILTSendedDataDelegate>

@property (nonatomic, strong) NSString *nextPage;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSURLConnection *tokenRequestConnection;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) ILTRepository *repository;
- (NSString *) getURlForAuthintification;
- (NSURLRequest *) representRequest:(NSString *)url;
- (void)addDataFromNetwork:(NSData *)data;
- (void)setToken;
- (void)requestTags:(NSString *)url tagForSearch:(NSString *)tag;

@end
