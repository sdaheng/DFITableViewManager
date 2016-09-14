//
//  MMYTableViewDelegateProxy.h
//  ReserveByCharming
//
//  Created by SDH on 8/12/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class DFITableViewConfiguration;
@protocol UITableViewDelegate;

@interface DFITableViewDelegateProxy : NSObject

+ (DFITableViewDelegateProxy *)tableViewDelegateProxyWithTableViewConfiguration:(DFITableViewConfiguration *)tableViewConfiguration;

@end
