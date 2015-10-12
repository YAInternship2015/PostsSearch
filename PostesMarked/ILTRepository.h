//
//  ILTRepository.h
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/6/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILTInstagramPoste.h"
#import "ILTDataProviderDelegate.h"

#warning этот класс не является NSFetchedResultsControllerDelegate
@interface ILTRepository : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) id<ILTDataProviderDelegate> delegate;
- (void)saveDataFromNetwork:(NSArray *)array;
#warning метод с таким именем должен возвращать целой число, а не массив. Вообще не нужно возвращать массив из этого класса, только общее количество элементов и элемент по конкретному indexPath
- (NSArray *)numberOfItems;
- (void)deleteItemAtIndexPath:(NSIndexPath *)index;
#warning не нужно показывать наружу NSFetchedResultsController, чтобы устанавливать ему делегат. Лучше реализуйте метод setFetchedResultsControllerDelegate:
- (NSFetchedResultsController *)getFetchedResultsController;
- (void)loadNextPage;

@end
