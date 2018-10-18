//
//  DFITableViewCellOption.h
//  DFInfrastructure
//
//  Created by SDH on 12/11/15.
//  Copyright © 2015 com.dazhongcun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol UITableViewCellActionDelegate;

@protocol DFITableViewCellOption <NSObject>

@property (nonatomic, strong) UIStoryboard *storyboard;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) UIViewController *presentFromViewController;

@property (nonatomic, copy) NSString *storyboardIDString;

@property (nonatomic, strong) id needTransferViewModel;

@property (nonatomic, weak) id<UITableViewCellActionDelegate> cellActionDelegate;

@property (nonatomic, assign) UITableViewCellSelectionStyle cellSelectionStyle;
@property (nonatomic, assign) UITableViewCellAccessoryType  cellAccessoryType;
@property (nonatomic, strong) UIView *cellAccessoryView;

@property (nonatomic, assign) BOOL hideNativeSeparator;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, assign) UIEdgeInsets separatorInsets;
@property (nonatomic, assign) CGFloat separatorHeight;

@end

@interface DFITableViewCellOption : NSObject <DFITableViewCellOption>

@end
