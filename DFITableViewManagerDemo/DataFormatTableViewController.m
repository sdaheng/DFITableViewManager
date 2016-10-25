//
//  DataFormatViewController.m
//  DFITableViewManagerDemo
//
//  Created by sdaheng on 16/9/14.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import "DataFormatTableViewController.h"

#import "DataFormatTableViewControllerViewModel.h"

#import "DemoCustomCell.h"

@interface DataFormatTableViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DataFormatTableViewControllerViewModel *viewModel;

@end

@implementation DataFormatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewModel];
    
    // Do any additional setup after loading the view.
}

- (DataFormatTableViewControllerViewModel *)viewModel {
    if (!_viewModel) {
        
        NSDictionary *dataSourceFormat = @{@"0-0" : @{DFITableViewCellReuseIdentifierStringKey : @"cell",
                                                      DFITableViewCellRowIsSameInSectionKey : @(YES)},
                                           DFITableViewCellSectionIsSameInTableView : @(YES)};
        
        DFITableViewConfiguration *tableViewConfiguration =
        [DFITableViewConfiguration configureTableView:self.tableView withDataSourceFormat:dataSourceFormat];
        
        _viewModel = [[DataFormatTableViewControllerViewModel alloc] initWithTableViewConfiguration:tableViewConfiguration];
        
        _viewModel.tableViewConfiguration.registerClassCells = @{@"cell" : [DemoCustomCell class]};
    }
    return _viewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
        
        [self.view addSubview:_tableView];
        
        _tableView.tableFooterView = [UIView new];
    }
    
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
