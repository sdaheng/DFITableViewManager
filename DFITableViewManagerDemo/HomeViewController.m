//
//  HomeViewController.m
//  DFITableViewManagerDemo
//
//  Created by sdaheng on 16/9/14.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import "HomeViewController.h"

#import "HomeViewControllerViewModel.h"

#import "DemoCustomCell.h"
#import "DemoCustomCellViewModel.h"

#import "CodeTableViewController.h"

@interface HomeViewController ()
#if !__has_include(<ReactiveCocoa/ReactiveCocoa.h>)
<UITableViewDelegate>
#endif

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HomeViewControllerViewModel *viewModel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
    @weakify(self)
    [self.viewModel.tableViewConfiguration.selectRowSignal
     subscribeNext:^(RACTuple * x) {
         @strongify(self)
         NSIndexPath *indexPath = [x second];

         [self selectCellAtIndexPath:indexPath];
     }];
#else
    self.viewModel.tableViewConfiguration.tableViewDelegate = self;
#endif
    
    for (NSArray *section in self.viewModel.dataSource) {
        for (DFITableViewCellViewModel *cellViewModel in section) {
            [cellViewModel makeOption:^(DFITableViewCellOption *option) {
                option.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }];
        }
    }
//    self.viewModel.tableViewConfiguration.tableViewDelegate = self;
    // Do any additional setup after loading the view.
}

#if !__has_include(<ReactiveCocoa/ReactiveCocoa.h>)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self selectCellAtIndexPath:indexPath];
}

#endif

- (void)selectCellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {

        NSArray *array = @[ @"Storyboard_ID_CodeTableViewController",
                            @"Storyboard_ID_DataFormatTableViewController",
                            @"Storyboard_ID_PlistTableViewController" ];

        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main"
                                                                                 bundle:nil]
                                                       instantiateViewControllerWithIdentifier:array[indexPath.row]]
                                             animated:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (HomeViewControllerViewModel *)viewModel {
    if (!_viewModel) {
        DFITableViewConfiguration *tableViewConfiguration = [DFITableViewConfiguration configureTableView:self.tableView];
        
        _viewModel = [[HomeViewControllerViewModel alloc] initWithTableViewConfiguration:tableViewConfiguration];
        
        _viewModel.tableViewConfiguration.registerClassCells = @{@"cell" : [DemoCustomCell class]};
    }
    
    return _viewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];
        
        [self.view addSubview:_tableView];
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
