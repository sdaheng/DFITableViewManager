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
    
    for (id value in self) {
        [tempArray addObject:block(value)];
    }

    return [tempArray copy];
}

@end
