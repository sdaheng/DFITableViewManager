//
//  DFITableViewConfiguartionInternal.h
//  DFITableViewManagerDemo
//
//  Created by SDH on 24/10/2016.
//  Copyright © 2016 sdaheng. All rights reserved.
//

@import UIKit;

@class RACSignal;

NS_ASSUME_NONNULL_BEGIN
@protocol DFITableViewConfigurationInternal <NSObject>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak, nullable) id<UITableViewDelegate> tableViewDelegate;

@property (nonatomic, weak, nullable) id<UITableViewDataSource> tableViewDataSource;

@property (nonatomic, copy) NSArray *dataSource;

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
@property (nonatomic, strong) RACSignal *selectRowSignal;
#endif

- (UITableViewCell *)cellForConfigurationAtIndexPath:(NSIndexPath *)indexPath;

@end
NS_ASSUME_NONNULL_END
