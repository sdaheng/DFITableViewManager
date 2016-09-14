//
//  DFIButtonTableViewCellViewModel.m
//  DFInfrastructure
//
//  Created by SDH on 11/19/15.
//  Copyright © 2015 com.dazhongcun. All rights reserved.
//

#import "DFIButtonTableViewCellViewModel.h"

@implementation DFIButtonTableViewCellViewModel

- (instancetype)initWithButtonTitleString:(NSString *)buttonTitleString {
    self = [super initWithCellConfigure:[[DFITableViewCellConfigure alloc] initWithReuseIdentifier:NSStringFromClass([self class])]];
    if (self) {
        _buttonTitleString = buttonTitleString;
    }
    
    return self;
}

@end
