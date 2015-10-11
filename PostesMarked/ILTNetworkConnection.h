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

@interface ILTNetworkConnection : NSObject <ILTDataProviderDelegate>

@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSURLConnection *tokenRequestConnection;
@property (nonatomic, strong) ILTRepository *repository;
- (NSString *) urlForAuthentification;
- (void)recieveDataFromServer:(NSString *)urlServer tagForSearch:(NSString *)tag;
- (void)loadNextPage;

@end
