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
    _networkConnection = [[ILTNetworkConnection alloc] init];
}

#pragma mark - started searching information 

- (IBAction)startSearchTags:(UIButton *)sender {
    if (_networkConnection.accessToken  == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Error", nil)
                                                        message: NSLocalizedString(@"Please, login to Instagram", nil)
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else {
        [ _networkConnection requestTags:nil tagForSearch:_textField.text];
    }
}

#pragma mark - send data another controllerl 

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"login"]) {
        ILTLoginWebViewController * login = (ILTLoginWebViewController *)[segue destinationViewController];
        login.networkConnection = _networkConnection;
    }
    if ([[segue identifier] isEqualToString:@"showTags"]) {
        ILTTagsShowTableViewController * tagsShow = (ILTTagsShowTableViewController *)[segue destinationViewController];
        tagsShow.repository = _networkConnection.repository;
    }
}

@end
