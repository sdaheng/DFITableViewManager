//
//  DemoCell.m
//  TableViewConfigurationDemo
//
//  Created by sdaheng on 16/8/17.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import "DemoCustomCell.h"
#import "DemoCustomCellViewModel.h"

#import <DFITableViewCells/DFITableViewCells.h>

@interface DemoCustomCell () <UITableViewCellConfigureProtocol>

@end

@implementation DemoCustomCell

- (void)configureCellWithInfo:(id)info
                       option:(NSDictionary * _Nullable)option {
    self.textLabel.text = ((DemoCustomCellViewModel *)info).text;
}

@end
