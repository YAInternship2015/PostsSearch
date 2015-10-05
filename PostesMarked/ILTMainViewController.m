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

@interface ILTMainViewController ()

@property ( nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, strong) ILTNetworkConnection *networkConnection;

@end

@implementation ILTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _networkConnection = [[ILTNetworkConnection alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)startSearchTags:(UIButton *)sender {
    if (_networkConnection.accessToken  == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please, login to Instagram"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"login"]) {
        ILTLoginWebViewController * login =(ILTLoginWebViewController *) [segue destinationViewController];
        login.networkConnection = _networkConnection;
    }
    else {
        NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent",_textField.text];
    }
}

@end
