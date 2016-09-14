//
//  DFIButtonTableViewCellViewModel.h
//  DFInfrastructure
//
//  Created by SDH on 11/19/15.
//  Copyright © 2015 com.dazhongcun. All rights reserved.
//

#import "DFITableViewCellViewModel.h"

#if __has_include (<ReactiveCocoa/ReactiveCocoa.h>)
#import <ReactiveCocoa/ReactiveCocoa.h>
#endif

@interface DFIButtonTableViewCellViewModel : DFITableViewCellViewModel

@property (nonatomic, copy) NSString *buttonTitleString;

@property (nonatomic, copy) void (^buttonClickBlock)(UITableViewCell *cell, UIButton *button);

#if __has_include (<ReactiveCocoa/ReactiveCocoa.h>)
@property (nonatomic, strong) RACCommand *buttonCommand;
#endif

@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL selector;

- (instancetype)initWithButtonTitleString:(NSString *)buttonTitleString;

@end
