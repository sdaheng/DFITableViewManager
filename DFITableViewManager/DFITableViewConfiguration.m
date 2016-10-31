//
//  DFITableViewConfiguration.m
//  DFITableViewConfigration
//
//  Created by SDH on 11/2/15.
//  Copyright © 2015 sdaheng. All rights reserved.
//

#import "DFITableViewConfiguration.h"

#import "DFITableViewConfigurationInternal.h"

#import "UITableView+dequeueTableViewCell.h"

#import "DFITableViewDataSourceProxy.h"
#import "DFITableViewDelegateProxy.h"

#import <DFITableViewCells/DFITableViewCells.h>

@interface DFITableViewConfiguration () <DFITableViewConfigurationInternal>

@property (nonatomic, copy) NSDictionary <NSString *, NSNumber *> *configurationsIfRowIsSameInSection;

@property (nonatomic, assign) NSInteger sectionIndexIfSectionIsSameInTableView;
@property (nonatomic, assign) NSInteger rowIndexIfRowIsSameInSection;

@property (nonatomic, strong) DFITableViewDelegateProxy *delegateProxy;
@property (nonatomic, strong) DFITableViewDataSourceProxy *dataSourceProxy;

@end

@implementation DFITableViewConfiguration
@synthesize dataSourceDidChangeBlock = _dataSourceDidChangeBlock;

#pragma mark - init

+ (instancetype)configureTableView:(UITableView *)tableView
              withDataSourceFormat:(NSDictionary *)dataSourceFormat {
    return [[self alloc] initWithTableView:tableView
                          dataSourceFormat:dataSourceFormat];
}

+ (instancetype)configureTableView:(UITableView *)tableView {

    return [[self alloc] initWithTableView:tableView
                          dataSourceFormat:nil];
}

- (instancetype)initWithTableView:(UITableView *)tableView
                 dataSourceFormat:(NSDictionary *)dataSourceFormat {
    self = [super init];

    if (self) {
        _tableView = tableView;
        _dataSourceFormat = dataSourceFormat;
        
        _configurationsIfRowIsSameInSection = [NSDictionary dictionary];
        
        _sectionIndexIfSectionIsSameInTableView = -1;
        
        _dataSourceProxy =
        [DFITableViewDataSourceProxy tableViewDataSourceProxyWithTableViewConfiguration:self];
        
        _delegateProxy =
        [DFITableViewDelegateProxy tableViewDelegateProxyWithTableViewConfiguration:self];
    }
    
    return self;
}

- (instancetype)init {
    return nil;
}

+ (instancetype)new {
    return nil;
}

#pragma mark - setup cells

- (UITableViewCell *)cellForConfigurationAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.dataSourceFormat) {
        return [self dataSourceCellForRowAtIndexPath:indexPath];
    } else {
        return [self dataFormatCellForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)dataSourceCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DFITableViewCellViewModel *cellViewModel = [self setupDataSourceCellViewModelAtIndexPath:indexPath];
    
    return [self.tableView dequeueTableViewCellAtIndexPath:indexPath
                                       withReuseIdentifier:cellViewModel.cellConfigure.reuseIdentifierString
                                                      info:cellViewModel
                                                    option:nil];
}

- (DFITableViewCellViewModel *)setupDataSourceCellViewModelAtIndexPath:(NSIndexPath *)indexPath {
    DFITableViewCellViewModel *cellViewModel = self.dataSource[indexPath.section][indexPath.row];
    DFITableViewCellOption *cellOption = nil;
    
    if (self.cellOptionAtIndexPath) {
        cellOption = self.cellOptionAtIndexPath([NSIndexPath indexPathForRow:indexPath.row
                                                                   inSection:indexPath.section]);
    }
    
    cellViewModel.cellConfigure.cellOption = cellOption;
    
    return cellViewModel;
}

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

- (UITableViewCell *)dataFormatCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *cellOptionDictioanry = [self setupDataFormatCellOptionAtIndexPath:indexPath];
    
    NSString *indexPathString =
    [self dataFormatCellIndexPathStringIfRowIsSameInSectionOrNotAtIndexPath:indexPath];
    
    NSString *cellReuseIdentifierString =
    self.dataSourceFormat[indexPathString][DFITableViewCellReuseIdentifierStringKey];
    
    return [self.tableView dequeueTableViewCellAtIndexPath:indexPath
                                       withReuseIdentifier:cellReuseIdentifierString
                                                      info:self.dataSource[indexPath.section][indexPath.row]
                                                    option:cellOptionDictioanry];
}

- (NSString *)dataFormatCellIndexPathStringIfRowIsSameInSectionOrNotAtIndexPath:(NSIndexPath *)indexPath {
    return [self.configurationsIfRowIsSameInSection[@(indexPath.section).stringValue] boolValue] ?
           [NSString stringWithFormat:@"%@-%@", @(indexPath.section), @(self.rowIndexIfRowIsSameInSection)] :
           [NSString stringWithFormat:@"%@-%@", @(self.sectionIndexIfSectionIsSameInTableView != -1 ?
                                                  self.sectionIndexIfSectionIsSameInTableView : indexPath.section),
                                                @(indexPath.row)];
}

#pragma mark - setter

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    
    self.dataSourceDidChangeBlock();
}

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
- (void)setSelectRowSignal:(RACSignal *)selectRowSignal {
    _selectRowSignal = selectRowSignal;
}
#endif

- (void)setRegisterClassCells:(NSDictionary<NSString *, Class> *)registerCells {
    [registerCells
     enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key,
                                         Class  _Nonnull obj,
                                         BOOL * _Nonnull stop) {
         
         [self.tableView registerClass:obj
                forCellReuseIdentifier:key];
     }];
}

- (void)setRegisterNibCells:(NSDictionary<NSString *, UINib *> *)registerNibCells {
    [registerNibCells
     enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key,
                                         UINib * _Nonnull obj,
                                         BOOL * _Nonnull stop) {
         
         [self.tableView registerNib:obj
              forCellReuseIdentifier:key];
     }];
}

@end

#pragma mark - const

NSString * const DFITableViewCellReuseIdentifierStringKey = @"reuseIdentifier";

NSString * const DFITableViewCellRowIsSameInSectionKey = @"rowIsSameInSection";
NSString * const DFITableViewCellSectionIsSameInTableView = @"sectionIsSameInTableView";

NSString * const DFITableViewCellOptionKey = @"cellOption";

NSString * const DFITableViewCellStoryboardOptionKey = @"cellStoryboardOption";
NSString * const DFITableViewCellStoryboardIDOptionKey = @"cellStoryboardIDOption";
NSString * const DFITableViewCellNavigationControllerOptionKey = @"navigationControllerOption";
NSString * const DFITableViewCellPresentFromViewControllerOptionKey = @"presentFromViewControllerOption";

