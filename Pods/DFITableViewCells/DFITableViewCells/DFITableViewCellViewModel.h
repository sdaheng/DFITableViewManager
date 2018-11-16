//
//  MMYTableViewCellViewModel.h
//  MMY_Merchant
//
//  Created by SDH on 7/28/15.
//  Copyright (c) 2015 dazhongcun. All rights reserved.
//

#import "DFITableViewCellConfigure.h"
#import "DFITableViewFormChecker.h"

#define DFI_TABLEVIEWCELL_RESIGN_FIRST_RESPONDER \
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DFITableViewCellResignFirstResponder" object:nil];

@interface DFITableViewCellViewModel : NSObject

@property (nonatomic, assign) UITableViewCellStyle cellStyle;

@property (nonatomic, copy) NSString *tagString;

@property (nonatomic, strong) DFITableViewCellConfigure *cellConfigure;

@property (readonly, nonatomic, strong) id underlyingModel;

@property (readonly, nonatomic, copy) NSDictionary *formCheckerRulesDictionary;

- (instancetype)initWithCellConfigure:(DFITableViewCellConfigure *)cellConfigure;

- (void)addCheckers:(NSArray <DFITableViewFormCheckRule *> *)checkerRules
             forKey:(NSString *)key;

- (void)makeOption:(void(^)(__kindof DFITableViewCellOption *))option;

@end
