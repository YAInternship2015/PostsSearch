//
//  ILTSendedDataDelegate.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/7/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning плозое имя протокола, переименуйте его
@protocol ILTSendedDataDelegate <NSObject>

@property (nonatomic, strong) NSString *nextPage;
- (void)requestTags:(NSString *)url tagForSearch:(NSString *)tag;

@end