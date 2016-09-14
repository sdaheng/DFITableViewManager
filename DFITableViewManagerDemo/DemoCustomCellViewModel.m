//
//  CellViewModel.m
//  TableViewConfigurationDemo
//
//  Created by sdaheng on 16/8/17.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import "DemoCustomCellViewModel.h"

@interface DemoCustomCellViewModel ()

@end

@implementation DemoCustomCellViewModel

- (instancetype)initWithText:(NSString *)text {
    self = [super initWithCellConfigure:[[DFITableViewCellConfigure alloc] initWithReuseIdentifier:@"cell"]];
    if (self) {
        _text = text;
    }
    
    return self;
}

@end
