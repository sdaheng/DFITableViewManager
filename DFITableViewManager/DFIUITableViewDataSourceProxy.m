//
//  DFIUITableViewDataSourceProxy.m
//  DFInfrastructure
//
//  Created by SDH on 4/16/16.
//  Copyright © 2016 com.dazhongcun. All rights reserved.
//

#import "DFIUITableViewDataSourceProxy.h"

#import "DFITableViewConfiguration.h"

#import <UIKit/UIKit.h>

@interface DFIUITableViewDataSourceProxy () <UITableViewDataSource>

@property (nonatomic, strong) DFITableViewConfiguration *tableViewConfiguration;

@end

@implementation DFIUITableViewDataSourceProxy

- (instancetype)initWithTableViewConfiguration:(DFITableViewConfiguration *)tableViewConfigruation {
    
    self = [super init];
    
    if (self) {
        _tableViewConfiguration = tableViewConfigruation;

        _tableViewConfiguration.tableView.dataSource = self;
        
        [self addObserver:self
               forKeyPath:@"tableViewConfiguration.dataSource"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"tableViewConfiguration.dataSource"]) {
        
        if ([change[NSKeyValueChangeNewKey] count] > 0) {
            [self.tableViewConfiguration.tableView reloadData];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.tableViewConfiguration.tableViewDataSource &&
        [self.tableViewConfiguration.tableViewDataSource
         respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            
        return [self.tableViewConfiguration.tableViewDataSource numberOfSectionsInTableView:tableView];
    }
    
    if (self.tableViewConfiguration) {
        return self.tableViewConfiguration.dataSource.count;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    if (self.tableViewConfiguration.tableViewDataSource &&
        [self.tableViewConfiguration.tableViewDataSource
         respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            
            [self.tableViewConfiguration.tableViewDataSource tableView:tableView
                                                 numberOfRowsInSection:section];
        }
    
    if (self.tableViewConfiguration) {
        return [self.tableViewConfiguration.dataSource[section] count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.tableViewConfiguration.tableViewDataSource &&
        [self.tableViewConfiguration.tableViewDataSource
         respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
            
            return [self.tableViewConfiguration.tableViewDataSource tableView:tableView
                                                        cellForRowAtIndexPath:indexPath];
        } else {
            return [self.tableViewConfiguration cellForConfigurationAtIndexPath:indexPath];
        }
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableViewConfiguration.tableViewDataSource &&
        [self.tableViewConfiguration.tableViewDataSource
         respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
            
            return [self.tableViewConfiguration.tableViewDataSource tableView:tableView
                                                        canEditRowAtIndexPath:indexPath];
        } else {
            return NO;
        }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableViewConfiguration.tableViewDataSource &&
        [self.tableViewConfiguration.tableViewDataSource
         respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
            
            return [self.tableViewConfiguration.tableViewDataSource tableView:tableView
                                                        canMoveRowAtIndexPath:indexPath];
        } else {
            return NO;
        }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.tableViewConfiguration.tableViewDataSource &&
        [self.tableViewConfiguration.tableViewDataSource
         respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
            
            return [self.tableViewConfiguration.tableViewDataSource tableView:tableView
                                                      titleForHeaderInSection:section];
        }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (self.tableViewConfiguration.tableViewDataSource &&
        [self.tableViewConfiguration.tableViewDataSource
         respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
            
            return [self.tableViewConfiguration.tableViewDataSource tableView:tableView
                                                      titleForFooterInSection:section];
        }
    
    return nil;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.tableViewConfiguration.tableViewDataSource &&
        [self.tableViewConfiguration.tableViewDataSource
         respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
            
            return [self.tableViewConfiguration.tableViewDataSource
                    sectionIndexTitlesForTableView:tableView];
        }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView
sectionForSectionIndexTitle:(NSString *)title
               atIndex:(NSInteger)index {
    
    if (self.tableViewConfiguration.tableViewDataSource &&
        [self.tableViewConfiguration.tableViewDataSource respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [self.tableViewConfiguration.tableViewDataSource tableView:tableView
                                              sectionForSectionIndexTitle:title
                                                                  atIndex:index];
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.tableViewConfiguration.tableViewDataSource &&
        [self.tableViewConfiguration.tableViewDataSource
         respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
            
        [self.tableViewConfiguration.tableViewDataSource tableView:tableView
                                                commitEditingStyle:editingStyle
                                                 forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    if (self.tableViewConfiguration.tableViewDataSource &&
        [self.tableViewConfiguration.tableViewDataSource
         respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
            
        [self.tableViewConfiguration.tableViewDataSource tableView:tableView
                                                moveRowAtIndexPath:sourceIndexPath
                                                       toIndexPath:destinationIndexPath];
    }
}

- (void)dealloc {
    NSLog(@"dataSourceProxy dealloc");
    
    [self removeObserver:self
              forKeyPath:@"tableViewConfiguration.dataSource"];
}

@end
