//
//  ILTLoginWebViewController.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 9/28/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILTNetworkConnection.h"

@interface ILTLoginWebViewController : UIViewController <UIWebViewDelegate>
//@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, strong) ILTNetworkConnection *networkConnection;
@end
