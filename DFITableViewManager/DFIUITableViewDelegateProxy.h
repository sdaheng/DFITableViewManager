//
//  DFIUITableViewDelegateProxy.h
//  DFInfrastructure
//
//  Created by SDH on 4/16/16.
//  Copyright © 2016 com.dazhongcun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DFITableViewDelegateProxy.h"

@interface DFIUITableViewDelegateProxy : DFITableViewDelegateProxy

- (instancetype)initWithTableViewConfiguration:(id<DFITableViewConfigurationInternal>)tableViewConfiguration;

@end
