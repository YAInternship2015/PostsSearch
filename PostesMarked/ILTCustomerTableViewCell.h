//
//  ILTCustomerTableViewCell.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/7/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILTInstagramsPostes.h"

@interface ILTCustomerTableViewCell : UITableViewCell

- (void)setupWithItem:(ILTInstagramsPostes *)item;

@end
