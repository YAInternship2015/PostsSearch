//
//  ILTLoginWebViewController.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 9/28/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTLoginWebViewController.h"
#import "Defines.h"
#import "NSURLRequest+ILTNetworkConnection.h"



@interface ILTLoginWebViewController () 

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation ILTLoginWebViewController

#pragma mark - setup my id 

-(void)viewDidLoad {
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest  representRequest:[_networkConnection urlForAuthentification]]];
}

#pragma mark - webView starting and load request

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([[[request URL] host] isEqualToString:@"localhost"]) {
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
            NSString *dataString = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@", kClientID, kClientSecret,kRedirectURI, verifier];
            NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/access_token"];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
            _networkConnection.tokenRequestConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            _networkConnection.data = [[NSMutableData alloc] init];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    return YES;
}

#pragma mark - connection with server

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_networkConnection saveDataFromNetwork:data];
}

#pragma mark - if error connection show message 

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                    message:[NSString stringWithFormat:NSLocalizedString(@"%@", nil), error]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - set token

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [_networkConnection saveToken];
}

@end
