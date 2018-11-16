//
//  DFITextViewTableViewCellViewModel.m
//  MMYStylist
//
//  Created by SDH on 12/8/15.
//  Copyright © 2015 sdaheng. All rights reserved.
//

#import "DFITextViewTableViewCellViewModel.h"

@implementation DFITextViewTableViewCellViewModel

- (instancetype)initWithTitleString:(NSString *)titleString
                        valueString:(NSString *)valueString {
    
    self = [super initWithCellConfigure:[[DFITableViewCellConfigure alloc] initWithReuseIdentifier:NSStringFromClass(self.class)]];
    
    if (self) {
        _titleString = titleString;
        _valueString = valueString;
    }
    
    return self;
}

- (void)makeOption:(void (^)(__kindof DFITableViewCellOption *))option {
    
    DFITextViewTableViewCellOption *_option = [DFITextViewTableViewCellOption new];
    
    option ? option(_option) : nil;
    
    self.cellConfigure.cellOption = _option;
}

@end

@implementation DFITextViewTableViewCellOption

@end
