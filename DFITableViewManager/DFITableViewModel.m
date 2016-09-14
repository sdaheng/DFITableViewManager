//
//  MMYBaseTableViewModel.m
//  ReserveByCharming
//
//  Created by SDH on 7/27/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#import "DFITableViewModel.h"

@interface DFITableViewModel ()

@end

@implementation DFITableViewModel

@synthesize pageNumber = _pageNumber;

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
@synthesize refreshSignal = _refreshSignal;
@synthesize loadMoreSignal = _loadMoreSignal;
#endif

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _dataSource = [NSArray array];
    }
    
    return self;
}

- (instancetype)initWithTableViewConfiguration:(DFITableViewConfiguration *)tableViewConfiguration {
    self = [super init];
    
    if (self) {
        _tableViewConfiguration = tableViewConfiguration;
        
        _dataSource = [NSArray array];
    }
    
    return self;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    
    if (!_tableViewConfiguration.dataSource) {
        [_tableViewConfiguration setValue:dataSource forKey:@"dataSource"];
    }
}

- (void)setTableViewConfiguration:(DFITableViewConfiguration *)tableViewConfiguration {
    _tableViewConfiguration = tableViewConfiguration;
    
    if (!_tableViewConfiguration.dataSource) {
        [_tableViewConfiguration setValue:_dataSource forKey:@"dataSource"];
    }
}

@end
