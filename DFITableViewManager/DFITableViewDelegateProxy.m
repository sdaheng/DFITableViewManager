//
//  MMYTableViewDelegateProxy.m
//  ReserveByCharming
//
//  Created by SDH on 8/12/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#import "DFITableViewDelegateProxy.h"

#import "DFITableViewConfiguration.h"

#import "DFIUITableViewDelegateProxy.h"

@interface DFITableViewDelegateProxy ()

@end

@implementation DFITableViewDelegateProxy

+ (DFITableViewDelegateProxy *)tableViewDelegateProxyWithTableViewConfiguration:(DFITableViewConfiguration *)tableViewConfiguration {
    return [[DFIUITableViewDelegateProxy alloc] initWithTableViewConfiguration:tableViewConfiguration];
}

@end
