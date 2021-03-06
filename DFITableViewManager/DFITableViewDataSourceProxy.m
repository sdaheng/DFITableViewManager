//
//  MMYTableViewProxy.m
//  ReserveByCharming
//
//  Created by SDH on 7/27/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#import "DFITableViewDataSourceProxy.h"

#import "DFIUITableViewDataSourceProxy.h"

@interface DFITableViewDataSourceProxy ()

@end

@implementation DFITableViewDataSourceProxy

+ (instancetype)proxyWithTableViewConfiguration:(id<DFITableViewConfigurationInternal>)tableViewConfiguration {
    return [[DFIUITableViewDataSourceProxy alloc] initWithTableViewConfiguration:tableViewConfiguration];
}

@end
