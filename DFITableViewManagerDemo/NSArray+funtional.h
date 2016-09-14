//
//  NSArray+funtional.h
//  TableViewConfigurationDemo
//
//  Created by sdaheng on 16/8/17.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (funtional)

- (NSArray *)map:(id (^)(id value))block;

@end
