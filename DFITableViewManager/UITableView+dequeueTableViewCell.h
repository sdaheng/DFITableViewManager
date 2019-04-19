//
//  UITableView+generateCustomCell.h
//  DFITableViewConfigration
//
//  Created by SDH on 11/2/15.
//  Copyright © 2015 sdaheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DFITableViewCellViewModel;

@interface UITableView (dequeueTableViewCell)

- (UITableViewCell *)configureTableViewCellAtIndexPath:(NSIndexPath *)indexPath
                                   withReuseIdentifier:(NSString *)identifier
                                                  info:(id)info
                                                option:(id)option;

@end
