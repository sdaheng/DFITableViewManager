//
//  MMYTableViewProxy.h
//  ReserveByCharming
//
//  Created by SDH on 7/27/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DFITableViewConfigurationInternal.h"

@interface DFITableViewDataSourceProxy : NSObject

+ (instancetype)proxyWithTableViewConfiguration:(id<DFITableViewConfigurationInternal>)tableViewConfiguration;

@end
