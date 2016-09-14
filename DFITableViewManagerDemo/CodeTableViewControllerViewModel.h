//
//  ViewControllerViewModel.h
//  DFITableViewManagerDemo
//
//  Created by sdaheng on 16/9/10.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFITableViewManager.h"
#import "DFIConcreteTableViewCells.h"

@interface CodeTableViewControllerViewModel : DFITableViewModel

@property (nonatomic, strong, readonly) DFIButtonTableViewCellViewModel *confirmButtonCellViewModel;

@end
