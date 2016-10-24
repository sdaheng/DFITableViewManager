//
//  DFITableViewConfiguration.m
//  DFITableViewConfigration
//
//  Created by SDH on 11/2/15.
//  Copyright © 2015 sdaheng. All rights reserved.
//

#import "DFITableViewConfiguration.h"

#import "UITableView+dequeueTableViewCell.h"

#import "DFITableViewDataSourceProxy.h"
#import "DFITableViewDelegateProxy.h"

#import <DFITableViewCells/DFITableViewCells.h>

@interface DFITableViewConfiguration ()

@property (nonatomic, copy) NSDictionary <NSString *, NSNumber *> *configurationsIfRowIsSameInSection;

@property (nonatomic, assign) NSInteger sectionIndexIfSectionIsSameInTableView;
@property (nonatomic, assign) NSInteger rowIndexIfRowIsSameInSection;

@property (nonatomic, strong) DFITableViewDelegateProxy *delegateProxy;
@property (nonatomic, strong) DFITableViewDataSourceProxy *dataSourceProxy;

@end

@implementation DFITableViewConfiguration

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

#define INDEX_KEY_IF_ROW_IS_SAME_IN_SECTION                        \
        [NSString stringWithFormat:@"%@-%@", @(indexPath.section), \
        @(self.rowIndexIfRowIsSameInSection)]

#define INDEX_KEY                                                           \
        [NSString stringWithFormat:@"%@-%@",                                \
         @(self.sectionIndexIfSectionIsSameInTableView != -1 ?              \
         self.sectionIndexIfSectionIsSameInTableView : indexPath.section),  \
         @(indexPath.row)]

- (NSDictionary *)setupDataFormatCellOptionAtIndexPath:(NSIndexPath *)indexPath {
    NSString *indexPathKeyString = [NSString stringWithFormat:@"%@-%@", @(indexPath.section),
                                    @(indexPath.row)];
    
    NSDictionary *cellConfigurationDictionary = self.dataSourceFormat[indexPathKeyString];
    
    BOOL sectionIsSameInTableView =
    self.dataSourceFormat[kTableViewCellSectionIsSameInTableView];
    
    self.sectionIndexIfSectionIsSameInTableView = sectionIsSameInTableView ? 0 : -1;
    
    if (![self.configurationsIfRowIsSameInSection[[@(indexPath.section) stringValue]] boolValue] &&
        cellConfigurationDictionary[kTableViewCellRowIsSameInSectionKey]) {
        NSMutableDictionary *tempMutableDictionary = [self.configurationsIfRowIsSameInSection mutableCopy];
        [tempMutableDictionary setObject:cellConfigurationDictionary[kTableViewCellRowIsSameInSectionKey]
                                  forKey:@(indexPath.section).stringValue];
        self.configurationsIfRowIsSameInSection = [tempMutableDictionary copy];
        
        self.rowIndexIfRowIsSameInSection = indexPath.row;
    }
    
    NSString *indexPathString =
    [self dataFormatCellIndexPathStringIfRowIsSameInSectionOrNotAtIndexPath:indexPath];
    
    NSDictionary *cellOptionDictioanry =
    self.dataSourceFormat[indexPathString][kTableViewCellOptionKey];
    
    return [cellOptionDictioanry copy];
}

- (UITableViewCell *)dataFormatCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *cellOptionDictioanry = [self setupDataFormatCellOptionAtIndexPath:indexPath];
    
    NSString *indexPathString =
    [self dataFormatCellIndexPathStringIfRowIsSameInSectionOrNotAtIndexPath:indexPath];
    
    NSString *cellReuseIdentifierString =
    self.dataSourceFormat[indexPathString][kTableViewCellReuseIdentifierStringKey];
    
    return [self.tableView dequeueTableViewCellAtIndexPath:indexPath
                                       withReuseIdentifier:cellReuseIdentifierString
                                                      info:self.dataSource[indexPath.section][indexPath.row]
                                                    option:cellOptionDictioanry];
}

- (NSString *)dataFormatCellIndexPathStringIfRowIsSameInSectionOrNotAtIndexPath:(NSIndexPath *)indexPath {
    BOOL rowIsSameInSection =
    [self.configurationsIfRowIsSameInSection[@(indexPath.section).stringValue] boolValue];
    
    NSString *indexPathString = rowIsSameInSection ? INDEX_KEY_IF_ROW_IS_SAME_IN_SECTION : INDEX_KEY;
    
    return [indexPathString copy];
}

#undef INDEX_KEY_IF_ROW_IS_SAME_IN_SECTION
#undef INDEX_KEY

#pragma mark - setter

- (void)setDataSourceFormat:(NSDictionary<NSString *, NSDictionary *> *)dataSourceFormat {
    
    _dataSourceFormat = dataSourceFormat;
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kTableViewDataSourceFormatDidChangedNotification object:self];
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:DFITableViewDataSourceDidChangeNotification object:nil];
}

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

NSString * const kTableViewDataSourceFormatDidChangedNotification = @"kTableViewDataSourceFormatDidChangedNotification";
NSString * const DFITableViewDataSourceDidChangeNotification = @"DFITableViewDataSourceDidChangeNotification";

NSString * const kTableViewCellReuseIdentifierStringKey = @"reuseIdentifier";

NSString * const kTableViewCellRowIsSameInSectionKey = @"rowIsSameInSection";
NSString * const kTableViewCellSectionIsSameInTableView = @"sectionIsSameInTableView";

NSString * const kTableViewCellOptionKey = @"cellOption";

NSString * const kTableViewCellStoryboardOptionKey = @"cellStoryboardOption";
NSString * const kTableViewCellStoryboardIDOptionKey = @"cellStoryboardIDOption";
NSString * const kTableViewCellNavigationControllerOptionKey = @"navigationControllerOption";
NSString * const kTableViewCellPresentFromViewControllerOptionKey = @"presentFromViewControllerOption";

