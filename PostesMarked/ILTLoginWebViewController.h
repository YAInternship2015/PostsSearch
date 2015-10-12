//
//  ILTLoginWebViewController.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 9/28/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILTNetworkConnection.h"

#warning поддержку протокола UIWebViewDelegate перенесите в *.m
@interface ILTLoginWebViewController : UIViewController <UIWebViewDelegate>

#warning закомментированный код надо удалить, и заодно импорт ILTNetworkConnection
//@property (nonatomic, strong) ILTNetworkConnection *networkConnection;

@end
