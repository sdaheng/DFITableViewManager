//
//  MMYBaseTableViewModel.h
//  ReserveByCharming
//
//  Created by SDH on 7/27/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DFITableViewPaging.h"

#import "DFITableViewConfiguration.h"

@protocol DFITableViewModel <NSObject>

@end

@interface DFITableViewModel : NSObject <DFITableViewModel, DFITableViewPaging>

@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, strong) DFITableViewConfiguration *tableViewConfiguration;

- (instancetype)initWithTableViewConfiguration:(DFITableViewConfiguration *)tableViewConfiguration;

@end
