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

#import "DFITableViewViewModelDataSource.h"

@interface DFITableViewConfiguration () <DFITableViewConfigurationInternal>

@property (nonatomic, strong) DFITableViewDelegateProxy *delegateProxy;
@property (nonatomic, strong) DFITableViewDataSourceProxy *dataSourceProxy;

@end

@implementation DFITableViewConfiguration {
    DFITableViewDataSource *_backingDataSource;
}

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
        
        _backingDataSource = [DFITableViewDataSource dataSourceWithFormat:dataSourceFormat];
        
        _dataSourceProxy =
        [DFITableViewDataSourceProxy tableViewDataSourceProxyWithTableViewConfiguration:self];
        
        _delegateProxy =
        [DFITableViewDelegateProxy tableViewDelegateProxyWithTableViewConfiguration:self];
        
        [self registerDFITableViewConcretCells];
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



#pragma mark - setter

- (void)setDataSourceFormat:(NSDictionary<NSString *, NSDictionary *> *)dataSourceFormat {
    
    if (!_backingDataSource) {
        _backingDataSource = [DFITableViewDataSource dataSourceWithFormat:dataSourceFormat];
    } else {
        _backingDataSource.dataSourceFormat = dataSourceFormat;
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:DFITableViewDataSourceFormatDidChangedNotification object:self];
}

- (NSDictionary<NSString *,NSDictionary *> *)dataSourceFormat {
    return _backingDataSource.dataSourceFormat;
}

- (void)setDataSource:(NSArray *)dataSource {
//    _dataSource = dataSource; // use for displaying cells at first time
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf->_backingDataSource =
        [DFITableViewDataSource dataSourceWithRawSectionsAndRows:dataSource];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter]
             postNotificationName:DFITableViewDataSourceDidChangeNotification object:nil];
        });
    });
}

- (DFITableViewDataSource *)backingDataSource {
    return _backingDataSource;
}

- (NSArray *)dataSource {
    return [_backingDataSource rawArray];
}

- (void)setCellOptionAtIndexPath:(DFITableViewCellOptionBlock)cellOptionAtIndexPath {
    _backingDataSource.optionBlock = cellOptionAtIndexPath;
}

- (DFITableViewCellOptionBlock)cellOptionAtIndexPath {
    return _backingDataSource.optionBlock;
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

- (void)setRegisterCells:(NSArray *)registerCells {
    
    NSMutableDictionary *tempMutableClassDictionary =
    [NSMutableDictionary dictionaryWithCapacity:registerCells.count];
    NSMutableDictionary *tempMutableNibDictionary =
    [NSMutableDictionary dictionaryWithCapacity:registerCells.count];
    
    NSInteger nibIndex = 0;
    for (id cell in registerCells) {
        if ([cell isKindOfClass:[UINib class]]) {
            [tempMutableNibDictionary setObject:cell
                                         forKey:[@"Nib Cell" stringByAppendingFormat:@" %ld", nibIndex]];
        } else {
            [tempMutableClassDictionary setObject:cell forKey:NSStringFromClass(cell)];
        }
    }
    
    [self setRegisterClassCells:tempMutableClassDictionary];
    [self setRegisterNibCells:tempMutableNibDictionary];
}

#if __has_include(<DFITableViewCells/DFITableViewCells.h>)

- (void)registerDFITableViewConcretCells {
    self.registerClassCells =
    @{NSStringFromClass(DFIPlainTableViewCellViewModel.class) : DFIPlainTableViewCell.class,
      NSStringFromClass(DFITextFieldTableViewCellViewModel.class) : DFITextFieldTableViewCell.class,
      NSStringFromClass(DFITextViewTableViewCellViewModel.class) : DFITextViewTableViewCell.class,
      NSStringFromClass(DFIButtonTableViewCellViewModel.class) : DFIButtonTableViewCell.class,
      NSStringFromClass(DFISegmentedTableViewCell.class) : DFISegmentedTableViewCell.class};
}

#endif

@end

#pragma mark - const

NSString * const DFITableViewDataSourceFormatDidChangedNotification = @"DFITableViewDataSourceFormatDidChangedNotification";

NSString * const DFITableViewCellReuseIdentifierStringKey = @"reuseIdentifier";

NSString * const DFITableViewCellRowIsSameInSectionKey = @"rowIsSameInSection";
NSString * const DFITableViewCellSectionIsSameInTableView = @"sectionIsSameInTableView";

NSString * const DFITableViewCellOptionKey = @"cellOption";

NSString * const DFITableViewCellStoryboardOptionKey = @"cellStoryboardOption";
NSString * const DFITableViewCellStoryboardIDOptionKey = @"cellStoryboardIDOption";
NSString * const DFITableViewCellNavigationControllerOptionKey = @"navigationControllerOption";
NSString * const DFITableViewCellPresentFromViewControllerOptionKey = @"presentFromViewControllerOption";

