# DFITableViewManager

### 使用方法

```objective-c
DFITableViewConfiguration *tableViewConfiguration = 
[DFITableViewConfiguration configureTableView:self.tableView withRowIsSameInSection:nil];

tableViewConfiguration.registerClassCells = @{@"cell" : [DemoCustomCell class]};

self.dataSource = @[[@[ @"CodeDemo", @"DataFormatDemo", @"PlistDemo" ] map:^id(id value) {
    return [[DemoCustomCellViewModel alloc] initWithText:value];
}]];

// select row
// tableViewDelegate
tableViewConfiguration.tableViewDelegate = self;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [self selectCellAtIndexPath:indexPath];
}
// ReactiveCocoa
@weakify(self)
[tableViewConfiguration.selectRowSignal subscribeNext:^(RACTuple * x) {
     @strongify(self)
     NSIndexPath *indexPath = [x second];

     [self selectCellAtIndexPath:indexPath];
 }];
```

对于自定义cell

```objective-c
@interface DemoCustomCell : UITableViewCell

@end
  
@interface DemoCustomCell () <UITableViewCellConfigureProtocol>

@end

@implementation DemoCustomCell

- (void)configureCellWithInfo:(id)info
                       option:(NSDictionary * _Nullable)option {
    self.textLabel.text = ((DemoCustomCellViewModel *)info).text;
}

@end
  
// CellViewModel
@interface DemoCustomCellViewModel ()

@end

@implementation DemoCustomCellViewModel

- (instancetype)initWithText:(NSString *)text {
    DFITableViewCellConfigure *tableViewConfigure = 
    [[DFITableViewCellConfigure alloc] initWithReuseIdentifier:@"cell"];
    self = [super initWithCellConfigure:tableViewConfigure];
    if (self) {
        _text = text;
    }
    
    return self;
}

@end
```

