//
//  DFITableViewConfiguration.h
//  DFITableViewConfigration
//
//  Created by SDH on 11/2/15.
//  Copyright © 2015 sdaheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UITableViewDelegate;
@protocol UITableViewDataSource;

@class DFITableViewCellOption;

@class UITableView;
@class UITableViewCell;
@class UINib;

@class RACSignal;

NS_ASSUME_NONNULL_BEGIN

typedef __kindof DFITableViewCellOption * _Nullable (^DFITableViewCellOptionBlock)(NSIndexPath * indexPath);

@interface DFITableViewConfiguration : NSObject

@property (readonly, nonatomic, strong) UITableView *tableView;

/**
 *  数据源 格式必须为@[ @[ (row) ] (section) ]
 */
@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, copy, nullable) NSDictionary <NSString *, NSDictionary *> *dataSourceFormat;

@property (nonatomic, copy, nullable) NSDictionary <NSString *, Class>   *registerClassCells;
@property (nonatomic, copy, nullable) NSDictionary <NSString *, UINib *> *registerNibCells;

/**
 *  转发 UITableViewDelegate 中的方法
 */
@property (nonatomic, weak, nullable) id<UITableViewDelegate> tableViewDelegate;

/**
 *  转发 UITableViewDataSource 中的方法
 */
@property (nonatomic, weak, nullable) id<UITableViewDataSource> tableViewDataSource;

/**
 *  对应indexPath所在的Cell的配置选项
 */
@property (nonatomic, copy, nullable) DFITableViewCellOptionBlock cellOptionAtIndexPath;

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

/**
 *  根据配置返回相应的Cell
 *
 *  @param indexPath indexPath
 *
 *  @return 配置的Cell
 */
- (UITableViewCell *)cellForConfigurationAtIndexPath:(NSIndexPath *)indexPath;

@end

/**
 *  DataSourceFormat 发生变化后的通知
 */
extern NSString * const kTableViewDataSourceFormatDidChangedNotification;

extern NSString * const DFITableViewDataSourceDidChangeNotification;

/**
 *  以下是 dataSourceFormat 字典中所用的key
 */

/**
 *  Example
 *  section-row
 *  @{@"0-0" : @{kTableViewCellReuseIdentifierStringKey : @"cell1",
                 kTableViewCellOptionKey : @{kTableViewCellStoryboardOptionKey : self.storyboard,
                                             kTableViewCellNavigationControllerOptionKey : self.navigationController}},
      @"0-1" : @{kTableViewCellReuseIdentifierStringKey : @"cell2",
                 kTableViewCellOptionKey : @{kTableViewCellStoryboardOptionKey : self.storyboard,
                                             kTableViewCellNavigationControllerOptionKey : self.navigationController}},
      @"0-2" : @{kTableViewCellReuseIdentifierStringKey : @"cell3",
                 kTableViewCellOptionKey : @{kTableViewCellStoryboardOptionKey : self.storyboard,
                                             kTableViewCellNavigationControllerOptionKey : self.navigationController}},
      kTableViewCellSectionIsSameInTableView : @(YES)};
 
    From a plist file.
    xxx.plist
 
 */

/**
 *  TableViewCell的重用字符串
 */
extern NSString * const kTableViewCellReuseIdentifierStringKey;

/**
 *  TableView中所有的section里的Cell配置是否相同, 值为 BOOL NSNumber
 */
extern NSString * const kTableViewCellSectionIsSameInTableView;

/**
 *  TableView中section里的row是否相同, 值为 BOOL NSNumber
 */
extern NSString * const kTableViewCellRowIsSameInSectionKey;

/**
 *  配置Cell选项的key
 */
extern NSString * const kTableViewCellOptionKey;

/**
 *  配置Cell选项里的storyboard的key
 */
extern NSString * const kTableViewCellStoryboardOptionKey;

/**
 *  配置Cell选项里的storyboard Identifier的key
 */
extern NSString * const kTableViewCellStoryboardIDOptionKey;

/**
 *  配置Cell选项里的navigationController的key
 */
extern NSString * const kTableViewCellNavigationControllerOptionKey;

/**
 *  配置Cell选项里的UIViewController的key
 */
extern NSString * const kTableViewCellPresentFromViewControllerOptionKey;

NS_ASSUME_NONNULL_END
