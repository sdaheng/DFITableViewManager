//
//  UITableViewCell+configure.m
//  ReserveByCharming
//
//  Created by SDH on 15/3/6.
//  Copyright (c) 2015年 com.dazhongcun. All rights reserved.
//

#import "UITableViewCell+configure.h"
#import "UITableViewCellConfigureProtocol.h"
#import "DFITableViewCellViewModel.h"
#import "UITableViewCell+Separator.h"

@implementation UITableViewCell (configure)

- (void)configureWithInfo:(id)info {
    [self configureWithInfo:info
                     option:nil];
}

- (void)configureWithInfo:(id)info option:(id)option {

    id <UITableViewCellConfigureProtocol> interface = self;
    
    if (interface &&
        [interface respondsToSelector:@selector(configureCellWithInfo:option:)]) {
        DFITableViewCellOption *option = [[info cellConfigure] cellOption];
        if (option.hideNativeSeparator) {
            [self showSeparatorWithColor:option.separatorColor
                                  insets:option.separatorInsets];
        }
        [interface configureCellWithInfo:info option:option];
    }
}

@end
