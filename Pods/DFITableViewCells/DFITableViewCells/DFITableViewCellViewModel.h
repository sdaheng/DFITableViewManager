//
//  MMYTableViewCellViewModel.h
//  MMY_Merchant
//
//  Created by SDH on 7/28/15.
//  Copyright (c) 2015 dazhongcun. All rights reserved.
//

#import "DFITableViewCellConfigure.h"
#import "DFITableViewFormChecker.h"

@interface DFITableViewCellViewModel : NSObject

@property (nonatomic, assign) UITableViewCellStyle cellStyle;

@property (nonatomic, copy) NSString *tagString;

@property (nonatomic, strong) DFITableViewCellConfigure *cellConfigure;

@property (readonly, nonatomic, strong) id underlyingModel;

@property (readonly, nonatomic, copy) NSDictionary *formCheckerRulesDictionary;

- (instancetype)initWithCellConfigure:(DFITableViewCellConfigure *)cellConfigure;

- (void)addCheckers:(NSArray <DFITableViewFormCheckRule *> *)checkerRules
             forKey:(NSString *)key;

- (void)makeOption:(void(^)(DFITableViewCellOption *))option;

@end
