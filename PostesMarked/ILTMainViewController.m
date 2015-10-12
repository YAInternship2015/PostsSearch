//
//  ViewController.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 9/26/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTMainViewController.h"
#import "ILTNetworkConnection.h"
#import "ILTLoginWebViewController.h"
#import "ILTTagsShowTableViewController.h"

@interface ILTMainViewController ()

@property ( nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, strong) ILTNetworkConnection *networkConnection;

@end

@implementation ILTMainViewController

#pragma mark - initiallization connect past loading controller

- (void)viewDidLoad {
    [super viewDidLoad];
#warning первый момент - с UserDefaults должен работать не сам вью контроллер. В случае с accessToken должен быть какой-нибудь accessTokenManager, маленький класс, который может сохранить или вернуть токен. Его по необходимости будет создавать себе каждый класс, который работает с токеном. По поводу nextPage, его можно перенести в ILTNetworkConnection, который его и использует
    [[NSUserDefaults standardUserDefaults] setObject:nil
                                              forKey:@"nextPage"];
    [[NSUserDefaults standardUserDefaults] setObject:nil
                                              forKey:@"accessToken"];
    _textField.text = nil;
    _networkConnection = [[ILTNetworkConnection alloc] init];
}

#pragma mark - started searching information 

- (IBAction)startSearchTags:(UIButton *)sender {
    if ([[NSUserDefaults standardUserDefaults]
         objectForKey:@"accessToken"]  == nil) {
#warning текст "OK" тоже нужно поместить в Localizable.strings
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Error", nil)
                                                        message: NSLocalizedString(@"Please, login to Instagram", nil)
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else {
#warning лучше проверить [_textField.text length] > 0
        if (![_textField.text isEqualToString:@""]) {
            [_networkConnection recieveDataFromServer:nil tagForSearch:_textField.text];
        }
    }
}

#pragma mark - send data another controllerl 

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    /*if ([[segue identifier] isEqualToString:@"login"]) {
        ILTLoginWebViewController * login = (ILTLoginWebViewController *)[segue destinationViewController];
        login.networkConnection = _networkConnection;
    }*/
    if ([[segue identifier] isEqualToString:@"showTags"]) {
#warning tagsShowController
        ILTTagsShowTableViewController * tagsShow = (ILTTagsShowTableViewController *)[segue destinationViewController];
        tagsShow.repository = _networkConnection.repository;
    }
}

@end
