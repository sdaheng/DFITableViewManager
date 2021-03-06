//
//  DFITableViewConfiguartionInternal.h
//  DFITableViewManagerDemo
//
//  Created by SDH on 24/10/2016.
//  Copyright © 2016 sdaheng. All rights reserved.
//

@import UIKit;

@class RACSignal;
@class DFITableViewDataSource;

NS_ASSUME_NONNULL_BEGIN
@protocol DFITableViewConfigurationInternal <NSObject>

@property (readonly, nonatomic, strong) UITableView *tableView;

@property (readonly, nonatomic, weak, nullable) id<UITableViewDelegate> tableViewDelegate;

@property (readonly, nonatomic, weak, nullable) id<UITableViewDataSource> tableViewDataSource;

@property (readonly, nonatomic, strong) DFITableViewDataSource *backingDataSource;

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
@property (nonatomic, strong) RACSignal *selectRowSignal;
#endif

@end
NS_ASSUME_NONNULL_END
