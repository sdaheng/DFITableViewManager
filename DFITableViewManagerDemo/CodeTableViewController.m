//
//  ViewController.m
//  DFITableViewManagerDemo
//
//  Created by sdaheng on 16/9/8.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import "CodeTableViewController.h"

#import "DFITableViewManager.h"
#import "DFITableViewCells.h"
#import "DFIConcreteTableViewCells.h"
#import "CodeTableViewControllerViewModel.h"

#import "DemoCustomCell.h"
#import "DFIConcreteTableViewCells.h"

@interface CodeTableViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CodeTableViewControllerViewModel *viewModel;

@end

@implementation CodeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    self.viewModel.confirmButtonCellViewModel.buttonClickBlock = ^(UITableViewCell *cell,
                                                                   UIButton *button) {
        @strongify(self);
        [self showAlert];
    };
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)showAlert {
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"Tip"
                                        message:@"Login Success"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * _Nonnull action) {
                               [alertController dismissViewControllerAnimated:YES
                                                                   completion:nil];
                           }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];
        
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

- (CodeTableViewControllerViewModel *)viewModel {
    if (!_viewModel) {
        DFITableViewConfiguration  *tableViewConfiguration =
        [DFITableViewConfiguration configureTableView:self.tableView
                               withRowIsSameInSection:nil];
        _viewModel = [[CodeTableViewControllerViewModel alloc] initWithTableViewConfiguration:tableViewConfiguration];
        _viewModel.tableViewConfiguration.registerClassCells =
        @{NSStringFromClass([DFITextFieldTableViewCellViewModel class]) : [DFITextFieldTableViewCell class],
          NSStringFromClass([DFIButtonTableViewCellViewModel class]) : [DFIButtonTableViewCell class]};
    }
    
    return _viewModel;
}

@end
