//
//  ILTLoginWebViewController.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 9/28/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTLoginWebViewController.h"
#import "Defines.h"



@interface ILTLoginWebViewController () 

//@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, strong) ILTNetworkConnection *networkConnection;

@end

@implementation ILTLoginWebViewController

#pragma mark - setup my id 

-(void)viewDidLoad {
    self.webView.delegate = self;
    _networkConnection = [[ILTNetworkConnection alloc]init];
   // NSString *scopeStr = @"scope=likes+comments";
    
   // NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&display=touch&%@&redirect_uri=http://localhost&response_type=code", kClientID, scopeStr];
    
    [self.webView loadRequest:[_networkConnection representRequest:[_networkConnection getURlForAuthintification]]];//[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([[[request URL] host] isEqualToString:@"localhost"]) {
        
        // Extract oauth_verifier from URL query
        NSString* verifier = nil;
        NSArray* urlParams = [[[request URL] query] componentsSeparatedByString:@"&"];
        for (NSString* param in urlParams) {
            NSArray* keyValue = [param componentsSeparatedByString:@"="];
            NSString* key = [keyValue objectAtIndex:0];
            if ([key isEqualToString:@"code"]) {
                verifier = [keyValue objectAtIndex:1];
                break;
            }
        }
        
        if (verifier) {
            
            NSString *dataString = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@",kClientID,kClientSecret,kRedirectURI,verifier];
            
            NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/access_token"];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
            _networkConnection.tokenRequestConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
            _networkConnection.data = [[NSMutableData alloc] init];
        } else {
            // ERROR!
        }
        
        [self.webView removeFromSuperview];
        
        return NO;
    }
    return YES;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_networkConnection addDataFromNetwork:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"%@", error]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [_networkConnection setToken];
}

@end
