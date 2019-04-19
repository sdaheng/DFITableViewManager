//
//  UITableView+generateCustomCell.m
//  DFITableViewConfigration
//
//  Created by SDH on 11/2/15.
//  Copyright © 2015 sdaheng. All rights reserved.
//

#import "UITableView+dequeueTableViewCell.h"

@import DFITableViewCells;

@implementation UITableView (dequeueTableViewCell)

- (UITableViewCell *)configureTableViewCellAtIndexPath:(NSIndexPath *)indexPath
                                   withReuseIdentifier:(NSString *)identifier
                                                  info:(id)info
                                                option:(id)option {
    
    if (!identifier) return nil;

    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier
                                                       forIndexPath:indexPath];
   
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    
    [cell configureWithInfo:info option:option];
    
    return cell;
}

@end
