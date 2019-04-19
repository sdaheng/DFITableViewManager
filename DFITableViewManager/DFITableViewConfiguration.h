//
//  DFITableViewConfiguration.h
//  DFITableViewConfigration
//
//  Created by SDH on 11/2/15.
//  Copyright © 2015 sdaheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DFITableViewManagerDefines.h"

@protocol UITableViewDelegate;
@protocol UITableViewDataSource;

@class DFITableViewCellOption;

@class UITableView;
@class UITableViewCell;
@class UINib;

@class RACSignal;

typedef void(^DFITableViewDataSourceCompletion)();

NS_ASSUME_NONNULL_BEGIN

@interface DFITableViewConfiguration : NSObject

@property (readonly, nonatomic, strong) UITableView *tableView;

/**
 *  数据源 格式必须为@[ @[ (row) ] (section) ]
 */
@property (nonatomic, copy) NSArray *dataSource;

// use for describe cell style or options
@property (nonatomic, copy, nullable) NSDictionary <NSString *, NSDictionary *> *dataSourceFormat;

@property (nonatomic, copy, nullable) NSDictionary <NSString *, Class>   *registerClassCells;
@property (nonatomic, copy, nullable) NSDictionary <NSString *, UINib *> *registerNibCells;
@property (nonatomic, copy, nullable) NSArray *registerCells;

/**
 *  转发 UITableViewDelegate 中的方法
 */
@property (nonatomic, weak, nullable) id<UITableViewDelegate> tableViewDelegate;

/**
 *  转发 UITableViewDataSource 中的方法
 */
@property (nonatomic, weak, nullable) id<UITableViewDataSource> tableViewDataSource;

@property (nonatomic, copy, nullable) NSArray<NSString *> *sectionIndexTitles;

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
@property (readonly, nonatomic, strong) RACSignal *selectRowSignal;
#endif

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new  NS_UNAVAILABLE;

/**
 *  配置TableView
 *
 *  @param tableView          需要配置的tableView
 *
 *  @return DFITableViewConfiguration 的实例
 */
+ (instancetype)configureTableView:(__kindof UITableView *)tableView;

/**
 *  通过Dictionary配置TableView
 *
 *  @param tableView        需要配置的tableView
 *  @param dataSourceFormat 数据源格式
 *
 *  @return DFITableViewConfiguration 的实例
 */
+ (instancetype)configureTableView:(__kindof UITableView *)tableView
              withDataSourceFormat:(NSDictionary * _Nonnull)dataSourceFormat;

- (void)setDataSource:(NSArray * _Nonnull)dataSource
           completion:(__nullable DFITableViewDataSourceCompletion)completion;

@end

NS_ASSUME_NONNULL_END
