//
//  ViewController.m
//  DFITableViewManagerDemo
//
//  Created by sdaheng on 16/9/8.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import "CodeTableViewController.h"

#import "DFITableViewManager.h"

#import "CodeTableViewControllerViewModel.h"

#import "DemoCustomCell.h"
#import <DFITableViewCells/DFITableViewCells.h>


@interface CodeTableViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CodeTableViewControllerViewModel *viewModel;

@end

@implementation CodeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#define BLOCK
#ifdef BLOCK
    @weakify(self);
    self.viewModel.confirmButtonCellViewModel.buttonClickBlock = ^(UITableViewCell *cell,
                                                                   UIButton *button) {
        @strongify(self);
        [self showAlert];
    };
#endif
    
//#define TARGET_SELECTOR
#ifdef TARGET_SELECTOR
    [self.viewModel.confirmButtonCellViewModel addTarget:self action:@selector(showAlert)];
#endif
    
//#define RACCOMMAND
#ifdef RACCOMMAND
    @weakify(self)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        [self showAlert];
        return nil;
    }];
    
    self.viewModel.confirmButtonCellViewModel.buttonCommand =
    [[RACCommand alloc] initWithEnabled:[RACSignal return:@(YES)]
                            signalBlock:^RACSignal *(id input) {
        return signal;
    }];
#endif
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
          NSStringFromClass([DFIButtonTableViewCellViewModel class]) : [DFIButtonTableViewCell class],
          NSStringFromClass([DFIPlainTableViewCellViewModel class]) : [DFIPlainTableViewCell class],
          NSStringFromClass([DFISegmentedTableViewCellViewModel class]) : [DFISegmentedTableViewCell class]};
    }
    
    return _viewModel;
}

@end
