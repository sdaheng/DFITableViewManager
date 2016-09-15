//
//  HomeViewControllerViewModel.m
//  DFITableViewManagerDemo
//
//  Created by sdaheng on 16/9/14.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import "HomeViewControllerViewModel.h"

#import "NSArray+funtional.h"

#import "DemoCustomCellViewModel.h"

@interface HomeViewControllerViewModel ()

@end

@implementation HomeViewControllerViewModel

- (instancetype)initWithTableViewConfiguration:(DFITableViewConfiguration *)tableViewConfiguration{
    
    if (self = [super initWithTableViewConfiguration:tableViewConfiguration]) {
        self.dataSource = @[ [@[ @"CodeDemo", @"DataFormatDemo", @"PlistDemo" ] map:^id(id value) {
            return [[DemoCustomCellViewModel alloc] initWithText:value];
        }] ];
    }
    
    return self;
}

@end
