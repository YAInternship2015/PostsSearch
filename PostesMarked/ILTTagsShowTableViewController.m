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


@interface ILTTagsShowTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;


@end

@implementation ILTTagsShowTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _fetchedResultsController = [_repository getFetchedResultsController];
    [_fetchedResultsController setDelegate:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - Namber of rows

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return[[_repository getCoreDataItems]count];
}

#pragma mark - Cell review

- (ILTCustomerTableViewCell *)tableView:(UITableView *)tableView
       cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ILTInstagramsPostes *item = [[_repository getCoreDataItems] objectAtIndex:indexPath.row];
    ILTCustomerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    [cell setupWithItem:item];
    return cell;
}

#pragma mark - renew talbe

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

#pragma  mark - delete row with animation

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_repository deleteItem:indexPath];
        [self.tableView endUpdates];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == ([[_repository getCoreDataItems]count]-5)) {
        [_repository nextLoading];
    }
}
@end

