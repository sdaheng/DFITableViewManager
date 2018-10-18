//
//  DFITableViewSection.m
//  DFITableViewManagerDemo
//
//  Created by SDH on 2018/9/21.
//  Copyright © 2018 sdaheng. All rights reserved.
//

#import "DFITableViewViewModelDataSource.h"
#import "UITableView+dequeueTableViewCell.h"
#import "UITableViewCell+Separator.h"

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
    __weak typeof(self) weakSelf = self;
    dispatch_barrier_async(_queue, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSMutableArray *tempMutableArray = [strongSelf->_sectionArray mutableCopy];
        
        [tempMutableArray addObjectsFromArray:rows];
        
        strongSelf->_sectionArray = [tempMutableArray copy];
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

- (void)setIndex:(NSUInteger)index {
    _index = index;
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
    __weak typeof(self) weakSelf = self;
    dispatch_barrier_async(_queue, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSMutableArray *tempMutableArray = [strongSelf->_sectionArray mutableCopy];
        
        [tempMutableArray addObjectsFromArray:rows];
        
        strongSelf->_sectionArray = [tempMutableArray copy];
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

- (void)setIndex:(NSUInteger)index {
    _index = index;
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

@implementation DFITableViewRow {
    id<DFITableViewRowInfo> _rowInfo;
}

@synthesize indexPath = _indexPath;

+ (instancetype)rowWithInfo:(id<DFITableViewRowInfo>)rowInfo {
    return [[self alloc] initWithInfo:rowInfo];
}

- (instancetype)initWithInfo:(id<DFITableViewRowInfo>)rowInfo {
    if (self = [super init]) {
        _rowInfo = rowInfo;
    }
    return self;
}

- (id<DFITableViewRowInfo>)info {
    return _rowInfo;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

@end

@interface DFITableViewDataSource()

@property (nonatomic, copy) NSDictionary <NSString *, NSNumber *> *configurationsIfRowIsSameInSection;

@property (nonatomic, assign) NSInteger sectionIndexIfSectionIsSameInTableView;
@property (nonatomic, assign) NSInteger rowIndexIfRowIsSameInSection;

@end

@implementation DFITableViewDataSource {
    NSArray <id<DFITableViewSection>> *_backingDataSource;
    dispatch_queue_t _queue;
}

+ (instancetype)dataSourceWithFormat:(NSDictionary<NSString *,NSDictionary *> *)dataSourceFormat {
    return [[self alloc] initWithSections:[self mapDataSourceFormatToBackingDataSource:dataSourceFormat]];
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
        _configurationsIfRowIsSameInSection = [NSDictionary dictionary];
        
        _sectionIndexIfSectionIsSameInTableView = -1;
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
            [tempRowArray addObject:[DFITableViewRow rowWithInfo:row]];
        }];
        [tempDataSourceArray addObject:[DFITableViewViewModelSection sectionWithRows:tempRowArray]];
    }];
    return tempDataSourceArray;
}

+ (NSArray <id<DFITableViewSection>> *)mapDataSourceFormatToBackingDataSource:(NSDictionary *)dataSourceFormat {
    return @[];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
dataSourceCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[self[indexPath.section][indexPath.row] info]
         isKindOfClass:[DFITableViewCellViewModel class]]) {
        DFITableViewCellViewModel *cellViewModel = [self[indexPath.section][indexPath.row] info];
        
        UITableViewCell *cell = [tableView dequeueTableViewCellAtIndexPath:indexPath
                                      withReuseIdentifier:cellViewModel.cellConfigure.reuseIdentifierString
                                                     info:cellViewModel
                                                   option:nil];
        
        DFITableViewCellOption *_option = [[cellViewModel cellConfigure] cellOption];
        if (_option.hideNativeSeparator &&
            ((indexPath.section != _backingDataSource.count -1) &&
             (indexPath.row != _backingDataSource[indexPath.section].count - 1))) {
            [cell showSeparatorWithColor:_option.separatorColor
                                  insets:_option.separatorInsets
                                  height:_option.separatorHeight];
        }
        return cell;
    } else if ([[self[indexPath.section][indexPath.row] info] isKindOfClass:NSDictionary.class]) {
        return [self tableView:tableView dataFormatCellForRowAtIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - DataFormat

- (NSDictionary *)setupDataFormatCellOptionAtIndexPath:(NSIndexPath *)indexPath {
    NSString *indexPathKeyString = [NSString stringWithFormat:@"%@-%@", @(indexPath.section),
                                    @(indexPath.row)];
    
    NSDictionary *cellConfigurationDictionary = self.dataSourceFormat[indexPathKeyString];
    
    BOOL sectionIsSameInTableView =
    self.dataSourceFormat[DFITableViewCellSectionIsSameInTableView];
    
    self.sectionIndexIfSectionIsSameInTableView = sectionIsSameInTableView ? 0 : -1;
    
    if (![self.configurationsIfRowIsSameInSection[[@(indexPath.section) stringValue]] boolValue] &&
        cellConfigurationDictionary[DFITableViewCellRowIsSameInSectionKey]) {
        
        NSMutableDictionary *tempMutableDictionary = [self.configurationsIfRowIsSameInSection mutableCopy];
        
        [tempMutableDictionary setObject:cellConfigurationDictionary[DFITableViewCellRowIsSameInSectionKey]
                                  forKey:@(indexPath.section).stringValue];
        
        self.configurationsIfRowIsSameInSection = [tempMutableDictionary copy];
        
        self.rowIndexIfRowIsSameInSection = indexPath.row;
    }
    
    NSString *indexPathString =
    [self dataFormatCellIndexPathStringIfRowIsSameInSectionOrNotAtIndexPath:indexPath];
    
    NSDictionary *cellOptionDictioanry =
    self.dataSourceFormat[indexPathString][DFITableViewCellOptionKey];
    
    return [cellOptionDictioanry copy];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dataFormatCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *cellOptionDictioanry = [self setupDataFormatCellOptionAtIndexPath:indexPath];
    
    NSString *indexPathString =
    [self dataFormatCellIndexPathStringIfRowIsSameInSectionOrNotAtIndexPath:indexPath];
    
    NSString *cellReuseIdentifierString =
    self.dataSourceFormat[indexPathString][DFITableViewCellReuseIdentifierStringKey];
    
    return [tableView dequeueTableViewCellAtIndexPath:indexPath
                                  withReuseIdentifier:cellReuseIdentifierString
                                                 info:[self[indexPath.section][indexPath.row] info]
                                               option:cellOptionDictioanry];
}

#define stringfy(value) #value
#define concat(value1, value2, sep) value1##sep##value2

- (NSString *)dataFormatCellIndexPathStringIfRowIsSameInSectionOrNotAtIndexPath:(NSIndexPath *)indexPath {
    return [self.configurationsIfRowIsSameInSection[@(indexPath.section).stringValue] boolValue] ?
    [NSString stringWithFormat:@"%@-%@", @(indexPath.section), @(self.rowIndexIfRowIsSameInSection)] :
    [NSString stringWithFormat:@"%@-%@", @(self.sectionIndexIfSectionIsSameInTableView != -1 ?
     self.sectionIndexIfSectionIsSameInTableView : indexPath.section),
     @(indexPath.row)];
}

- (NSArray <NSArray *> *)rawArray {
    NSMutableArray *tempMutableSectionArray = [NSMutableArray array];
    [_backingDataSource enumerateObjectsUsingBlock:^(id<DFITableViewSection>  _Nonnull section,
                                                     NSUInteger idx,
                                                     BOOL * _Nonnull stop) {
        NSMutableArray *tempMutableRowArray = [NSMutableArray array];
        [section.rows enumerateObjectsUsingBlock:^(id<DFITableViewRow>  _Nonnull row,
                                                   NSUInteger idx,
                                                   BOOL * _Nonnull stop) {
            [tempMutableRowArray addObject:[row info]];
        }];
        [tempMutableSectionArray addObject:tempMutableRowArray];
    }];
    return tempMutableSectionArray;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id  _Nullable __unsafe_unretained [])buffer
                                    count:(NSUInteger)len {
    return [_backingDataSource countByEnumeratingWithState:state
                                                   objects:buffer
                                                     count:len];
}

- (NSArray<id<DFITableViewSection>> *)allSections {
    return _backingDataSource;
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
    __weak typeof(self) weakSelf = self;
    dispatch_barrier_async(_queue, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:strongSelf->_backingDataSource];
        
        [tempArray addObjectsFromArray:sections];
        
        strongSelf->_backingDataSource = [tempArray copy];
    });
}

- (void)addSection:(id<DFITableViewSection>)section {
    [self addSections:@[section]];
}

@end

@implementation DFITableViewCellViewModel (RowInfo)

- (id)info {
    return self;
}

@end

@implementation NSDictionary (RowInfo)

- (id)info {
    return self;
}

@end
