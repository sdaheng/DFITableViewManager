//
//  DFIButtonTableViewCell.m
//  DFInfrastructure
//
//  Created by SDH on 11/19/15.
//  Copyright © 2015 com.dazhongcun. All rights reserved.
//

#import "DFIButtonTableViewCell.h"

#import <Masonry/Masonry.h>

#import "UITableViewCellConfigureProtocol.h"

#import "DFIButtonTableViewCellViewModel.h"

#import "UIResponder+UITableViewCellResponderChain.h"
#import "DFIButtonTableViewCellOption.h"

NSString * const kButtonTitleStringKey = @"kButtonTitleStringKey";
NSString * const kButtonTitleColorKey = @"kButtonTitleColorKey";
NSString * const kButtonBackgroundColorKey = @"kButtonBackgroundColorKey";
NSString * const kButtonCornerRadiusKey = @"kButtonCornerRadiusKey";
NSString * const kButtonTitleFontKey = @"kButtonTitleFontKey";
NSString * const kButtonEdgeInsetsStringKey = @"kButtonEdgeInsetsStringKey";

NSString * const kButtonHideCellBackgroundColorKey = @"kButtonHideCellBackgroundColorKey";

NSString * const kButtonEnableKey = @"kButtonEnableKey";

@interface DFIButtonTableViewCell () <UITableViewCellConfigureProtocol>

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, assign) UIEdgeInsets buttonEdgeInsets;

@property (nonatomic, copy)   NSString *buttonTitleString;
@property (nonatomic, strong) UIColor *buttonTitleColor;
@property (nonatomic, strong) UIColor *buttonBackgroundColor;
@property (nonatomic, assign) CGFloat buttonCornerRadius;
@property (nonatomic, strong) UIFont *buttonTitleFont;

@property (nonatomic, strong) DFIButtonTableViewCellViewModel *cellViewModel;

@end

@implementation DFIButtonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //        [self commonInit];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //    [self commonInit];
}

- (void)commonInit {
    [self initViews];
    [self addViews];
    [self setupViewConstraints];
    //    [self setupViews];
    [self bindingViews];
}

- (void)initViews {
}

- (void)addViews {
}

- (void)setupViewConstraints {
    
}

- (void)setupViews {
    [self.button setTitle:self.self.buttonTitleString
                 forState:self.cellViewModel.state];
    [self.button setTitleColor:self.buttonTitleColor
                      forState:UIControlStateNormal];
    
    self.button.titleLabel.font = self.buttonTitleFont;
    
    [self.button setBackgroundColor:self.buttonBackgroundColor];
    
    if (self.buttonCornerRadius > 0) {
        self.button.layer.cornerRadius = self.buttonCornerRadius;
        self.button.layer.masksToBounds = YES;
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindingViews {
    
}

- (void)handleTapButton:(UIButton *)button {
    if (self.cellViewModel.buttonClickBlock) {
        self.cellViewModel.buttonClickBlock(self, button);
    }
    
    UIResponder *responder = self;
    
    while (responder) {
        //        NSLog(@"responder: %@", [responder description]);
        responder = responder.nextResponder;
    }
    
    [self routeThroughCellResponderChainWithEventName:@"DFIButtonTableViewCellClickEvent"
                                             userInfo:nil];
}

- (void)configureCellWithInfo:(id)info option:(NSDictionary *)option {
    self.cellViewModel = info;
    
    self.buttonTitleString = self.cellViewModel.buttonTitleString;
    
    [self.button setTitle:self.cellViewModel.buttonTitleString
                 forState:UIControlStateNormal];
    
    if (self.cellViewModel.cellConfigure.cellOption) {
        DFIButtonTableViewCellOption *option = (DFIButtonTableViewCellOption *)self.cellViewModel.cellConfigure.cellOption;
        
        self.buttonCornerRadius = option.cornerRadius;
        self.buttonEdgeInsets = [option buttonInsects];
        self.buttonBackgroundColor = option.backgroundColor;
        self.buttonTitleColor = option.titleTextColor;
        [self.button setTitleColor:self.buttonTitleColor
                          forState:UIControlStateNormal];
        self.buttonTitleFont = option.buttonFont;
        if (option.hideBackground) {
            self.contentView.backgroundColor = [UIColor clearColor];
            self.backgroundColor = [UIColor clearColor];
        } else {
            self.contentView.backgroundColor = [UIColor whiteColor];
            self.backgroundColor = [UIColor clearColor];
        }
    } else {
        self.buttonTitleColor = option[kButtonTitleColorKey];
        self.buttonBackgroundColor = option[kButtonBackgroundColorKey];
        self.buttonTitleFont = option[kButtonTitleFontKey];
        self.buttonCornerRadius = [option[kButtonCornerRadiusKey] floatValue];
        self.buttonEdgeInsets = UIEdgeInsetsFromString(option[kButtonEdgeInsetsStringKey]);
        
        if ([option[kButtonHideCellBackgroundColorKey] boolValue]) {
            self.contentView.backgroundColor = [UIColor clearColor];
            self.backgroundColor = [UIColor clearColor];
        } else {
            self.contentView.backgroundColor = [UIColor whiteColor];
            self.backgroundColor = [UIColor clearColor];
        }
    }
    
    if (self.cellViewModel.target &&
        self.cellViewModel.selector) {
        
        [self.button addTarget:self.cellViewModel.target
                        action:self.cellViewModel.selector
              forControlEvents:UIControlEventTouchUpInside];
    }
#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
    else if (self.cellViewModel.buttonCommand) {
        self.button.rac_command = self.cellViewModel.buttonCommand;
    }
#endif
    else {
        [self.button addTarget:self
                        action:@selector(handleTapButton:)
              forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self setupViews];
}

- (void)setButtonEdgeInsets:(UIEdgeInsets)buttonEdgeInsets {
    _buttonEdgeInsets = buttonEdgeInsets;
    
    [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(buttonEdgeInsets);
    }];
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [self.contentView addSubview:_button];
        
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsZero);
        }];
    }
    return _button;
}

@end
