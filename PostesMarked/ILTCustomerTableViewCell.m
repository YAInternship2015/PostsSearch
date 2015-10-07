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
- (void)setupWithItem:(ILTInstagramsPostes *)item {
    int height = [item.sizeHeight intValue];
    int width = [item.sizeWidtch intValue];
    CGRect frameRect = _textView.frame;
    frameRect.size.height = height;
    _textView.frame = frameRect;
    frameRect = imageView.frame;
    frameRect.size.height = height;
    frameRect.size.width = width;
    imageView.frame = frameRect;
    imageView.image = [item getImage];
    _textView.text = [item comentText];
    
}

@end
