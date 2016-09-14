//
//  MMYTableViewProxy.h
//  ReserveByCharming
//
//  Created by SDH on 7/27/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DFITableViewConfiguration;

@interface DFITableViewDataSourceProxy : NSObject

+ (instancetype)tableViewDataSourceProxyWithTableViewConfiguration:(DFITableViewConfiguration *)tableViewConfiguration;

@end
