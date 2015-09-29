//
//  ILTLoginWebViewController.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 9/28/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTLoginWebViewController.h"
#import "Defines.h"
#import "UrlEncoding.h"


@interface ILTLoginWebViewController () 

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSMutableData *data;
@property(nonatomic, strong) NSURLConnection *tokenRequestConnection;

@end

@implementation ILTLoginWebViewController

#pragma mark - setup my id 

-(void) dealloc
{
    [_tokenRequestConnection cancel];
    self.webView.delegate = nil;
}

-(void)viewDidLoad {
    self.webView.delegate = self;
    //See http://instagram.com/developer/authentication/ for more details.
    
    NSString *scopeStr = @"scope=basic+likes+comments";
    
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&display=touch&%@&redirect_uri=http://localhost&response_type=code", kClientID, scopeStr];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.webView stopLoading];
    
    if([error code] == -1009)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot open the page because it is not connected to the Internet." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *responseURL = [request.URL absoluteString];
    
    NSString *urlCallbackPrefix = [NSString stringWithFormat:@"%@/?code=", kRedirectURI];
    
    //We received the code, now request the auth token from Instagram.
    if([responseURL hasPrefix:urlCallbackPrefix])
    {
        NSString *authToken = [responseURL substringFromIndex:[urlCallbackPrefix length]];
        
        NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/oauth/access_token"];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        
        NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:authToken, @"code", kRedirectURI, @"redirect_uri", @"authorization_code", @"grant_type",  kClientID, @"client_id",  kClientSecret, @"client_secret", nil];
        
        NSString *paramString = [paramDict urlEncodedString];
        
        NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
        
        [request setHTTPMethod:@"POST"];
        [request addValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@",charset] forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[paramString dataUsingEncoding:NSUTF8StringEncoding]];
        
        self.tokenRequestConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        [self.tokenRequestConnection start];
        
        return NO;
    }
    
    return YES;
}

#pragma Mark NSURLConnection delegates

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return cachedResponse;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.data setLength:0];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *jsonError = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:&jsonError];
    if(jsonData && [NSJSONSerialization isValidJSONObject:jsonData])
    {
        NSString *accesstoken = [jsonData objectForKey:@"access_token"];
        if(accesstoken)
        {
            //[self.authDelegate didAuthWithToken:accesstoken];
            return;
        }
    }
    
   // [self.authDelegate didAuthWithToken:nil];
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
    return request;
}

@end
