//
//  CellViewModel.h
//  TableViewConfigurationDemo
//
//  Created by sdaheng on 16/8/17.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import <DFITableViewCells/DFITableViewCells.h>

@interface DemoCustomCellViewModel : DFITableViewCellViewModel

@property (nonatomic, copy, readonly) NSString *text;

- (instancetype)initWithText:(NSString *)text;

@end
