//
//  ILTLoginWebViewController.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 9/28/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTLoginWebViewController.h"
#import "ILTNetworkConnection.h"


@interface ILTLoginWebViewController () 

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, strong) ILTNetworkConnection *networkConnection;

@end

@implementation ILTLoginWebViewController

#pragma mark - setup my id 

-(void)viewDidLoad {
    self.webView.delegate = self;
    _networkConnection = [[ILTNetworkConnection alloc]init];
   // NSString *scopeStr = @"scope=likes+comments";
    
   // NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&display=touch&%@&redirect_uri=http://localhost&response_type=code", kClientID, scopeStr];
    
    [self.webView loadRequest:[_networkConnection representRequest:[_networkConnection getURlForAuthintification]]];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([[[request URL]host] isEqualToString:@"localhost"]) {
        NSString *verifier = nil;
        NSArray *urlParams = [[[request URL]query] componentsSeparatedByString:@"&"];
        for (NSString* param in urlParams) {
            NSArray* keyValue = [param componentsSeparatedByString:@"="];
            NSString* key = [keyValue objectAtIndex:0];
            if ([key isEqualToString:@"code"]) {
                verifier = [keyValue objectAtIndex:1];
                break;
            }
        }
        
        if (verifier) {
            
            NSString *data = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@",kClientID,kClientSecret,kRedirectURI,verifier];
            
            NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/access_token"];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
            _tokenRequestConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
            _data = [[NSMutableData alloc] init];
        }
        [webView removeFromSuperview];
        return NO;
    }
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
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
    NSError *jsonError = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:&jsonError];
    if(jsonData && [NSJSONSerialization isValidJSONObject:jsonData])
    {
        NSString *accesstoken = [jsonData objectForKey:@"access_token"];
       /* NSString *pdata = [NSString stringWithFormat:@"type=3&token=%@&secret=123&login=%@", accesstoken , @"xxxx"];
        UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Instagram Access TOken"
                              message:pdata
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alertView show];*/
    }
}

@end
