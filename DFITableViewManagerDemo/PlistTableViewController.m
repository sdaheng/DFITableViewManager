//
//  PlistTableViewController.m
//  DFITableViewManagerDemo
//
//  Created by sdaheng on 16/9/14.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import "PlistTableViewController.h"

#import "PlistTableViewControllerViewModel.h"

#import "DemoCustomCell.h"

@interface PlistTableViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PlistTableViewControllerViewModel *viewModel;

@end

@implementation PlistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewModel];
    
    // Do any additional setup after loading the view.
}

- (PlistTableViewControllerViewModel *)viewModel {
    if (!_viewModel) {
        
        NSDictionary *dataSourceFormat = [NSDictionary dictionaryWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"PlistDemo" withExtension:@"plist"]];
        
        DFITableViewConfiguration *tableViewConfiguration =
        [DFITableViewConfiguration configureTableView:self.tableView withDataSourceFormat:dataSourceFormat];
        
        _viewModel = [[PlistTableViewControllerViewModel alloc] initWithTableViewConfiguration:tableViewConfiguration];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
