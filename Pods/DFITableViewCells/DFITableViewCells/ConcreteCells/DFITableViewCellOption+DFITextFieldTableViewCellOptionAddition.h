//
//  DFITableViewCellOption+DFITextFieldTableViewCellOptionAddition.h
//  DFInfrastructure
//
//  Created by SDH on 3/18/16.
//  Copyright © 2016 com.dazhongcun. All rights reserved.
//

#import "DFITableViewCellOption.h"

@interface DFITableViewCellOption (DFITextFieldTableViewCellOptionAddition)

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, assign) UITextFieldViewMode leftViewMode;
@property (nonatomic, assign) UITextFieldViewMode rightViewMode;

@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) BOOL secureEntry;

@property (nonatomic, assign) NSTextAlignment textAlignment;

@property (nonatomic, assign) BOOL textFieldEnable;

@end
