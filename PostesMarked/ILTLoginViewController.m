//
//  ILTLoginViewController.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 9/28/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTLoginViewController.h"

@interface ILTLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ILTLoginViewController

#pragma mark - did load veiw controller

- (void)viewDidLoad {
    _imageView.layer.cornerRadius = 10;
    _imageView.clipsToBounds = YES;
    //_imageView.frame = 200;
}

#pragma mark - press button OK

- (IBAction)pressOKConnectInstagram:(id)sender {
}

#pragma mark - press button Cancel

- (IBAction)pressCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
