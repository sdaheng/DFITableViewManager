//
//  DFITableViewConfiguartionInternal.h
//  DFITableViewManagerDemo
//
//  Created by SDH on 24/10/2016.
//  Copyright © 2016 sdaheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface DFITableViewConfiguartionInternal : NSObject

@property (readonly, nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *dataSource;

@end
