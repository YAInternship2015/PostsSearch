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
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSURLConnection *connection;

@end

@implementation ILTLoginWebViewController

#pragma mark - setup my id 

-(void)viewDidLoad {
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest  representRequest:[NSString stringWithFormat:AUTHENTIFICATION, kClientID, @"scope=likes+comments"]]];
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
            //_networkConnection.tokenRequestConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
           // _networkConnection.data = [[NSMutableData alloc] init];
            _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
            _data = [[NSMutableData alloc]init];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    return YES;
}

#pragma mark - connection with server

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
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
    NSError *jsonError = nil;
    NSString *accessToken = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:&jsonError];
    if(jsonData && [NSJSONSerialization isValidJSONObject:jsonData])
    {
        accessToken = [jsonData objectForKey:@"access_token"];
    }
    if (accessToken != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:accessToken
                                                  forKey:@"accessToken"];
    }
}

@end
