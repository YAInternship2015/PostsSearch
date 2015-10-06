//
//  ILTNetworkConnection.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/2/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ILTNetworkConnection : NSObject
@property (nonatomic, strong) NSURLConnection *tokenRequestConnection;
@property (nonatomic, strong) NSString *accessToken;
- (NSString *) getURlForAuthintification;
@property (nonatomic, strong) NSMutableData *data;
- (NSURLRequest *) representRequest:(NSString *)url;
//- (BOOL)startLoad:(NSURLRequest *)request viewController:(UIViewController *)controller;
- (void)addDataFromNetwork:(NSData *)data;
- (void)setToken;
- (void)requestTags:(NSString *)url tagForSearch:(NSString *) tag;

@end
