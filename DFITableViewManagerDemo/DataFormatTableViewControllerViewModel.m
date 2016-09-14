//
//  DataFormatTableViewControllerViewModel.m
//  DFITableViewManagerDemo
//
//  Created by sdaheng on 16/9/14.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import "DataFormatTableViewControllerViewModel.h"

#import "NSArray+funtional.h"
#import "DemoCustomCellViewModel.h"

@interface DataFormatTableViewControllerViewModel ()

@end

@implementation DataFormatTableViewControllerViewModel

- (instancetype)initWithTableViewConfiguration:(DFITableViewConfiguration *)tableViewConfiguration {
    if (self = [super initWithTableViewConfiguration:tableViewConfiguration]) {
        self.dataSource = @[ [@[ @"1",
                                 @"2",
                                 @"3",
                                 @"4",
                                 @"5" ] map:^id(id value) {
                                     DemoCustomCellViewModel *cellViewModel = [[DemoCustomCellViewModel alloc] initWithText:value];
                                     return cellViewModel;
                                 }] ];
    }
    
    return self;
}

@end
