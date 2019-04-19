//
//  DFITableViewManagerDefines.h
//  DFITableViewManagerDemo
//
//  Created by SDH on 2018/9/24.
//  Copyright © 2018 sdaheng. All rights reserved.
//

#ifndef DFITableViewManagerDefines_h
#define DFITableViewManagerDefines_h

#import <DFITableViewCells/DFITableViewCells.h>

typedef __kindof DFITableViewCellOption * _Nullable (^DFITableViewCellOptionBlock)(NSIndexPath * indexPath);

/**
 *  DataSourceFormat 发生变化后的通知
 */
extern NSString * const DFITableViewDataSourceFormatDidChangedNotification;

extern NSString * const DFITableViewDataSourceDidChangeNotification;

/**
 *  以下是 dataSourceFormat 字典中所用的key
 */

/**
 *  Example
 *  section-row
 *  @{@"0-0" : @{DFITableViewCellReuseIdentifierStringKey : @"cell1",
                 DFITableViewCellOptionKey : @{DFITableViewCellStoryboardOptionKey : self.storyboard,
                 DFITableViewCellNavigationControllerOptionKey : self.navigationController}},
      @"0-1" : @{DFITableViewCellReuseIdentifierStringKey : @"cell2",
                 DFITableViewCellOptionKey : @{DFITableViewCellStoryboardOptionKey : self.storyboard,
                 DFITableViewCellNavigationControllerOptionKey : self.navigationController}},
      @"0-2" : @{DFITableViewCellReuseIdentifierStringKey : @"cell3",
                 DFITableViewCellOptionKey : @{DFITableViewCellStoryboardOptionKey : self.storyboard,
                 DFITableViewCellNavigationControllerOptionKey : self.navigationController}},
                 DFITableViewCellSectionIsSameInTableView : @(YES)};
 
 From a plist file.
 xxx.plist
 
 */

/**
 *  TableViewCell的重用字符串
 */
extern NSString * const DFITableViewCellReuseIdentifierStringKey;

/**
 *  TableView中所有的section里的Cell配置是否相同, 值为 BOOL NSNumber
 */
extern NSString * const DFITableViewCellSectionIsSameInTableView;

/**
 *  TableView中section里的row是否相同, 值为 BOOL NSNumber
 */
extern NSString * const DFITableViewCellRowIsSameInSectionKey;

/**
 *  配置Cell选项的key
 */
extern NSString * const DFITableViewCellOptionKey;

/**
 *  配置Cell选项里的storyboard的key
 */
extern NSString * const DFITableViewCellStoryboardOptionKey;

/**
 *  配置Cell选项里的storyboard Identifier的key
 */
extern NSString * const DFITableViewCellStoryboardIDOptionKey;

/**
 *  配置Cell选项里的navigationController的key
 */
extern NSString * const DFITableViewCellNavigationControllerOptionKey;

/**
 *  配置Cell选项里的UIViewController的key
 */
extern NSString * const DFITableViewCellPresentFromViewControllerOptionKey;

#endif /* DFITableViewManagerDefines_h */
