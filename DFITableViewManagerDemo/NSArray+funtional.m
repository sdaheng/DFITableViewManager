//
//  NSArray+funtional.m
//  TableViewConfigurationDemo
//
//  Created by sdaheng on 16/8/17.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import "NSArray+funtional.h"

@implementation NSArray (funtional)

- (NSArray *)map:(id (^)(id value))block {
    NSParameterAssert(block);
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                       NSUInteger idx,
                                       BOOL * _Nonnull stop) {
        [tempArray addObject:block(obj)];
    }];
    
    return [tempArray copy];
}

@end
