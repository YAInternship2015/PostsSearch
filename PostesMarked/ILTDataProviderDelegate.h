//
//  ILTSendedDataDelegate.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/7/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILTDataProviderDelegate <NSObject>

- (void)requestTags:(NSString *)url tagForSearch:(NSString *)tag;
- (void)loadNextPage;

@end