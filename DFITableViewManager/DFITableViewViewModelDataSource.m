//
//  DFITableViewSection.m
//  DFITableViewManagerDemo
//
//  Created by SDH on 2018/9/21.
//  Copyright © 2018 sdaheng. All rights reserved.
//

#import "DFITableViewViewModelDataSource.h"
#import "UITableView+dequeueTableViewCell.h"

@import Dispatch;

@implementation DFITableViewViewModelSection {
    NSArray *_sectionArray;
    
    dispatch_queue_t _queue;
}
@synthesize index = _index;

+ (instancetype)sectionWithRows:(NSArray<id<DFITableViewRow>> *)rows {
    return [[self alloc] initWithRows:rows];
}

- (NSArray<id<DFITableViewRow>> *)rows {
    return _sectionArray;
}

- (void)addRows:(NSArray<id<DFITableViewRow>> *)rows {
    dispatch_barrier_async(_queue, ^{
        NSMutableArray *tempMutableArray = [_sectionArray mutableCopy];
        
        [tempMutableArray addObjectsFromArray:rows];
        
        _sectionArray = [tempMutableArray copy];
    });
}

- (instancetype)initWithRows:(NSArray<id<DFITableViewRow>> *)rows {
    if (self = [super init]) {
        _sectionArray = rows ?: [NSArray array];
        _queue = dispatch_queue_create("com.DFIFoundation.TableViewManager.sectionQueue",
                                       NULL);
    }
    return self;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id  _Nullable __unsafe_unretained [])buffer
                                    count:(NSUInteger)len {
    return [_sectionArray countByEnumeratingWithState:state
                                              objects:buffer
                                                count:len];
}

- (NSUInteger)count {
    return _sectionArray.count;
}

- (id)objectAtIndex:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        return nil;
    }
    return _sectionArray[index];
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self objectAtIndex:idx];
}

@end

@implementation DFITableViewDictionarySection {
    NSArray *_sectionArray;

    dispatch_queue_t _queue;
}
@synthesize index = _index;

+ (instancetype)sectionWithRows:(NSArray<id<DFITableViewRow>> *)rows {
    return [[self alloc] initWithRows:rows];
}

- (NSArray<id<DFITableViewRow>> *)rows {
    return _sectionArray;
}

- (void)addRows:(NSArray<id<DFITableViewRow>> *)rows {
    dispatch_barrier_async(_queue, ^{
        NSMutableArray *tempMutableArray = [_sectionArray mutableCopy];
        
        [tempMutableArray addObjectsFromArray:rows];
        
        _sectionArray = [tempMutableArray copy];
    });
}

- (instancetype)initWithRows:(NSArray<id<DFITableViewRow>> *)rows {
    if (self = [super init]) {
        _sectionArray = rows ?: [NSArray array];
        _queue = dispatch_queue_create("com.DFIFoundation.TableViewManager.sectionQueue",
                                       NULL);
    }
    return self;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id  _Nullable __unsafe_unretained [])buffer
                                    count:(NSUInteger)len {
    return [_sectionArray countByEnumeratingWithState:state
                                              objects:buffer
                                                count:len];
}

- (NSUInteger)count {
    return _sectionArray.count;
}

- (id)objectAtIndex:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        return nil;
    }
    return _sectionArray[index];
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self objectAtIndex:idx];
}

@end

@implementation DFITableViewCellViewModelRow
@synthesize indexPath = _indexPath;

+ (id<DFITableViewRow>)rowWithInfo:(id)info {
    if ([info isKindOfClass:DFITableViewCellViewModel.class]) {
        return [self rowWithCellViewModel:info];
    } else if ([info isKindOfClass:NSDictionary.class]) {
        return [DFITableViewDictionaryRow rowWithInfo:info];
    }
    return nil;
}

+ (instancetype)rowWithCellViewModel:(DFITableViewCellViewModel *)cellViewModel {
    return [[self alloc] initWithCellViewModel:cellViewModel];
}

- (instancetype)initWithCellViewModel:(DFITableViewCellViewModel *)cellViewModel {
    if (self = [super init]) {
        _cellViewModel = cellViewModel;
    }
    return self;
}

@end

@implementation DFITableViewDictionaryRow
@synthesize indexPath = _indexPath;

+ (id<DFITableViewRow>)rowWithInfo:(id)info {
    if ([info isKindOfClass:DFITableViewCellViewModel.class]) {
        return [DFITableViewCellViewModelRow rowWithInfo:info];
    } else if ([info isKindOfClass:NSDictionary.class]) {
        return [self rowWithInfo:info];
    }
    return nil;
}

+ (instancetype)rowWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _cellModelDictionary = dictionary;
    }
    return self;
}

@end

@implementation DFITableViewDataSource {
    NSArray <id<DFITableViewSection>> *_backingDataSource;
    dispatch_queue_t _queue;
}

+ (instancetype)dataSourceWithRawSectionsAndRows:(NSArray<NSArray *> *)dataSource {
    return [[self alloc] initWithSections:[self mapRawDataSourceToBackingDataSource:dataSource]];
}

+ (instancetype)dataSourceWithSections:(NSArray<id<DFITableViewSection>> *)sections {
    return [[self alloc] initWithSections:sections];
}

- (instancetype)initWithSections:(NSArray <id<DFITableViewSection>> *)sections {
    if (self = [super init]) {
        _backingDataSource = sections;
        _queue = dispatch_queue_create("com.DFIFoundation.TableViewManager.dataSourceQueue", NULL);
    }
    return self;
}

+ (NSArray <id<DFITableViewSection>> *)mapRawDataSourceToBackingDataSource:(NSArray *)dataSource {
    NSMutableArray *tempDataSourceArray = [NSMutableArray array];
    [dataSource enumerateObjectsUsingBlock:^(id  _Nonnull section,
                                             NSUInteger idx,
                                             BOOL * _Nonnull stop) {
        NSMutableArray *tempRowArray = [NSMutableArray array];
        [section enumerateObjectsUsingBlock:^(id  _Nonnull row,
                                              NSUInteger idx,
                                              BOOL * _Nonnull stop) {
            [tempRowArray addObject:[DFITableViewCellViewModelRow rowWithInfo:row]];
        }];
        [tempDataSourceArray addObject:[DFITableViewViewModelSection sectionWithRows:tempRowArray]];
    }];
    return tempDataSourceArray;
}

- (UITableViewCell *)tableView:(UITableView *)tableView dataSourceCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DFITableViewCellViewModel *cellViewModel = [self[indexPath.section][indexPath.row] cellViewModel];

    return [tableView dequeueTableViewCellAtIndexPath:indexPath
                                  withReuseIdentifier:cellViewModel.cellConfigure.reuseIdentifierString
                                                 info:cellViewModel
                                               option:nil];
}

- (NSArray <NSArray *> *)rawArray {
    return @[@[]];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id  _Nullable __unsafe_unretained [])buffer
                                    count:(NSUInteger)len {
    return [_backingDataSource countByEnumeratingWithState:state
                                                   objects:buffer
                                                     count:len];
}

- (NSUInteger)count {
    return _backingDataSource.count;
}

- (id)objectAtIndex:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        return nil;
    }
    return _backingDataSource[index];
}

@end

@implementation DFITableViewDataSource (IndexedSubscript)

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self objectAtIndex:idx];
}

@end

@implementation DFITableViewDataSource (Operations)

- (void)addSections:(NSArray<id<DFITableViewSection>> *)sections {
    dispatch_barrier_async(_queue, ^{
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:_backingDataSource];
        
        [tempArray addObjectsFromArray:sections];
        
        _backingDataSource = [tempArray copy];
    });
}

- (void)addSection:(id<DFITableViewSection>)section {
    [self addSections:@[section]];
}

@end
