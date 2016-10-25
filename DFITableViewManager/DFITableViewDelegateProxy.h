//
//  MMYTableViewDelegateProxy.h
//  ReserveByCharming
//
//  Created by SDH on 8/12/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DFITableViewConfigurationInternal;

@interface DFITableViewDelegateProxy : NSObject

+ (DFITableViewDelegateProxy *)tableViewDelegateProxyWithTableViewConfiguration:(id<DFITableViewConfigurationInternal>)tableViewConfiguration;

@end
