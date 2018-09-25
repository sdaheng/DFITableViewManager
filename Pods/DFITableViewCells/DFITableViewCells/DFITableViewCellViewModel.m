//
//  MMYTableViewCellViewModel.m
//  MMY_Merchant
//
//  Created by SDH on 7/28/15.
//  Copyright (c) 2015 dazhongcun. All rights reserved.
//

#import "DFITableViewCellViewModel.h"

@implementation DFITableViewCellViewModel {
    id _underlyingModel;
    
    NSDictionary <NSString *, DFITableViewFormCheckRule *>* _checkerRulesDictionay;
}

- (instancetype)initWithCellConfigure:(DFITableViewCellConfigure *)cellConfigure {
    self = [super init];
    
    if (self) {
        _cellConfigure = cellConfigure;
    }
    
    return self;
}

- (id)underlyingModel {
    return _underlyingModel;
}

- (void)addCheckers:(NSArray<DFITableViewFormCheckRule *> *)checkerRules forKey:(NSString *)key {
    NSMutableDictionary *tempMutableDictionay = [_checkerRulesDictionay ?: @{} mutableCopy];
    
    [tempMutableDictionay setObject:checkerRules
                             forKey:key];
    
    _checkerRulesDictionay = tempMutableDictionay.copy;
}

- (NSDictionary *)formCheckerRulesDictionary {
    return _checkerRulesDictionay;
}

- (void)makeOption:(void (^)(DFITableViewCellOption *))option {
    DFITableViewCellOption *_option = [DFITableViewCellOption new];
    
    option ? option(_option) : nil;
    
    self.cellConfigure.cellOption = _option;
}

@end
