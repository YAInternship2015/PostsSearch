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
#import "ILTAccessTokenManager.h"

@interface ILTMainViewController ()

@property ( nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, strong) ILTNetworkConnection *networkConnection;
@property (nonatomic, strong) ILTAccessTokenManager *manager;

@end

@implementation ILTMainViewController

#pragma mark - initiallization connect past loading controller

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [[ILTAccessTokenManager alloc]init];
    [_manager setAccessToken:nil];
    _textField.text = nil;
    _networkConnection = [[ILTNetworkConnection alloc] init];
}

#pragma mark - started searching information 

- (IBAction)startSearchTags:(UIButton *)sender {
    if ([_manager accessToken]  == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Error", nil)
                                                        message: NSLocalizedString(@"Please, login to Instagram", nil)
                                                       delegate:nil
                                              cancelButtonTitle: NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
    else {
        if ([_textField.text length] > 0) {
            [_networkConnection recieveDataFromServer:nil tagForSearch:_textField.text];
        }
    }
}

#pragma mark - send data another controllerl 

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
        if ([[segue identifier] isEqualToString:@"showTags"]) {
        ILTTagsShowTableViewController * tagsShowController = (ILTTagsShowTableViewController *)[segue destinationViewController];
        tagsShowController.repository = _networkConnection.repository;
    }
}

@end
