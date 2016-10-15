# DFITableViewManager

`DFITableViewManager` is data driven content manager for `UITableView`. It allows to manage content of `UITableView` with ease, both lists and forms.

### Usage

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

Custom Cell

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
@interface DemoCustomCellViewModel

@property(nonatomic, copy) NSString *text;

@end

@implementation DemoCustomCellViewModel

- (instancetype)initWithText:(NSString *)text {
    DFITableViewCellConfigure *tableViewCellConfigure =
    [[DFITableViewCellConfigure alloc] initWithReuseIdentifier:@"cell"];
    self = [super initWithCellConfigure:tableViewCellConfigure];
    if (self) {
        _text = text;
    }

    return self;
}

@end
```


### Demo

Build and run `DFITableViewManagerDemo.xcworkspace` in Xcode to see `DFITableViewManager` in action.


### Installation

#### CocoaPods

In your Podfile

```ruby
target 'Your target' do
  pod 'DFITableViewManager'
end
```

then

```shell
$ pod install
```
