//
//  DFITextViewTableViewCellViewModel.h
//  MMYStylist
//
//  Created by SDH on 12/8/15.
//  Copyright © 2015 sdaheng. All rights reserved.
//

#import "DFITableViewCells.h"

@interface DFITextViewTableViewCellOption : DFITableViewCellOption

@property (nonatomic, strong) UIColor *textViewBackgroundColor;

@property (nonatomic, strong) UIFont *textViewTextFont;
@property (nonatomic, strong) UIFont *textViewTitleFont;

@property (nonatomic, strong) UIColor *titleTextColor;
@property (nonatomic, strong) UIColor *textViewTextColor;

@property (nonatomic, strong) UIColor *placeholderTextColor;

@end

@interface DFITextViewTableViewCellViewModel : DFITableViewCellViewModel

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *valueString;

@property (nonatomic, copy) NSString *placeholderString;

@property (nonatomic, assign) BOOL becomeFirstResponder;

- (instancetype)initWithTitleString:(NSString *)titleString
                        valueString:(NSString *)valueString;

@end
