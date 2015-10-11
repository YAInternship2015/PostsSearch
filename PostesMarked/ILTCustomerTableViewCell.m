//
//  ILTCustomerTableViewCell.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/7/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTCustomerTableViewCell.h"

@interface ILTCustomerTableViewCell () 

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

@implementation ILTCustomerTableViewCell

@synthesize imageView;

#pragma mark - set image and text in cell 

- (void)setupWithItem:(ILTInstagramPoste *)item {
    imageView.image = [item getImage];
    _textView.text = [item commentText];
}

@end
