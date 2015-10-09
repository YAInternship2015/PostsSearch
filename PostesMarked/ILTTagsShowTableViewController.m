//
//  ILTTagsShowTableViewController.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/7/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTTagsShowTableViewController.h"
#import <CoreData/CoreData.h>
#import "ILTCustomerTableViewCell.h"
#import "Defines.h"

@interface ILTTagsShowTableViewController () <NSFetchedResultsControllerDelegate>

@end

@implementation ILTTagsShowTableViewController

#pragma mark - setup fetch controller after loaded controller 

- (void)viewDidLoad {
    [super viewDidLoad];
    [[_repository getFetchedResultsController] setDelegate:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - Namber of rows

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return[[_repository numberOfItems]count];
}

#pragma mark - Cell review

- (ILTCustomerTableViewCell *)tableView:(UITableView *)tableView
       cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ILTInstagramPoste *item = [[_repository numberOfItems] objectAtIndex:indexPath.row];
    ILTCustomerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    [cell setupWithItem:item];
    return cell;
}

#pragma mark - renew data for table

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

#pragma  mark - delete row with animation

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_repository deleteItemAtIndexPath:indexPath];
        [self.tableView endUpdates];
    }
}

#pragma mark - fetch new data when all view 

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == ([[_repository numberOfItems] count] - POINTOFLOADINGNEXTDATA)) {
        [_repository.delegate loadNextPage];
    }
}

@end

