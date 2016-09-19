//
//  ViewControllerViewModel.m
//  DFITableViewManagerDemo
//
//  Created by sdaheng on 16/9/10.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import "CodeTableViewControllerViewModel.h"

#import "NSArray+funtional.h"

#import "DemoCustomCellViewModel.h"

@interface CodeTableViewControllerViewModel ()

@property (nonatomic, strong) DFIPlainTableViewCellViewModel *textCellViewModel;
@property (nonatomic, strong) DFISegmentedTableViewCellViewModel *segmentedCellViewModel;

@property (nonatomic, strong) DFITextFieldTableViewCellViewModel *nameTextFieldCellViewModel;
@property (nonatomic, strong) DFITextFieldTableViewCellViewModel *passwordTextFieldCellViewModel;

@property (nonatomic, strong) DFIButtonTableViewCellViewModel *confirmButtonCellViewModel;

@end

@implementation CodeTableViewControllerViewModel

- (instancetype)initWithTableViewConfiguration:(DFITableViewConfiguration *)tableViewConfiguration {
    self = [super initWithTableViewConfiguration:tableViewConfiguration];
    if (self) {
        self.dataSource = @[ @[ self.textCellViewModel,
                                self.segmentedCellViewModel ],
                             @[ self.nameTextFieldCellViewModel,
                                self.passwordTextFieldCellViewModel ],
                             @[ self.confirmButtonCellViewModel ] ];
    }
    
    return self;
}

- (DFIPlainTableViewCellViewModel *)textCellViewModel {
    if (!_textCellViewModel) {
        _textCellViewModel = [[DFIPlainTableViewCellViewModel alloc] initWithTitleTextString:@"Title"
                                                                            detailTextString:@"detail"
                                                                             imageNameString:nil];
    }
    
    return _textCellViewModel;
}

- (DFISegmentedTableViewCellViewModel *)segmentedCellViewModel {
    if (!_segmentedCellViewModel) {
        _segmentedCellViewModel = [[DFISegmentedTableViewCellViewModel alloc] initWithTitle:@"Gender"
                                                                  titlesForSegmentedControl:@[@"Male",
                                                                                              @"Female"]
                                                                          defaulSelectIndex:0];
    }
    return _segmentedCellViewModel;
}

- (DFITextFieldTableViewCellViewModel *)nameTextFieldCellViewModel {
    if (!_nameTextFieldCellViewModel) {
        _nameTextFieldCellViewModel = [[DFITextFieldTableViewCellViewModel alloc] initWithTitleString:nil
                                                                                            textValue:nil];
        
        _nameTextFieldCellViewModel.cellConfigure = [[DFITableViewCellConfigure alloc] initWithReuseIdentifier:NSStringFromClass([DFITextFieldTableViewCellViewModel class])];
        
        _nameTextFieldCellViewModel.placeholderString = @"name";
        
        _nameTextFieldCellViewModel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _nameTextFieldCellViewModel;
}

- (DFITextFieldTableViewCellViewModel *)passwordTextFieldCellViewModel {
    if (!_passwordTextFieldCellViewModel) {
        _passwordTextFieldCellViewModel = [[DFITextFieldTableViewCellViewModel alloc] initWithTitleString:nil
                                                                                                textValue:nil];
        
        _passwordTextFieldCellViewModel.placeholderString = @"password";
        
        _passwordTextFieldCellViewModel.secureTextEntry = YES;
        
        _passwordTextFieldCellViewModel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _passwordTextFieldCellViewModel;
}

- (DFIButtonTableViewCellViewModel *)confirmButtonCellViewModel {
    if (!_confirmButtonCellViewModel) {
        _confirmButtonCellViewModel =
        [[DFIButtonTableViewCellViewModel alloc] initWithButtonTitleString:@"Login"];
    }
    
    return _confirmButtonCellViewModel;
}

@end
