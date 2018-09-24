//
//  DFITableViewSection.h
//  DFITableViewManagerDemo
//
//  Created by SDH on 2018/9/21.
//  Copyright © 2018 sdaheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DFITableViewManagerDefines.h"

#import <DFITableViewCells/DFITableViewCells.h>

@protocol DFITableViewRow <NSObject>

@property (readonly, nonatomic, strong) NSIndexPath *indexPath;

+ (id<DFITableViewRow>)rowWithInfo:(id)info;

@end

@protocol DFITableViewSection <NSObject, NSFastEnumeration>

@property (readonly, nonatomic, assign) NSUInteger *index;

+ (instancetype)sectionWithRows:(NSArray<id<DFITableViewRow>>*)rows;

- (NSArray <id<DFITableViewRow>> *)rows;

- (void)addRows:(NSArray <id<DFITableViewRow>> *)rows;

- (NSUInteger)count;

@end

NS_ASSUME_NONNULL_BEGIN

@interface DFITableViewDictionaryRow : NSObject <DFITableViewRow>

@property (readonly, nonatomic, copy) NSDictionary *cellModelDictionary;

+ (instancetype)rowWithDictionary:(NSDictionary *)dictionary;

@end

@interface DFITableViewCellViewModelRow : NSObject <DFITableViewRow>

@property (readonly, nonatomic, strong) DFITableViewCellViewModel *cellViewModel;

+ (instancetype)rowWithCellViewModel:(DFITableViewCellViewModel *)cellViewModel;

@end

@interface DFITableViewViewModelSection : NSObject <DFITableViewSection>

@end

@interface DFITableViewDictionarySection : NSObject <DFITableViewSection>

@property (nonatomic, assign) BOOL rowConfigurationIsSameInSection;

@end

@interface DFITableViewDataSource : NSObject <NSFastEnumeration>

@property (nonatomic, copy) DFITableViewCellOptionBlock optionBlock;

+ (instancetype)dataSourceWithRawSectionsAndRows:(NSArray <NSArray *> *)dataSource;
+ (instancetype)dataSourceWithSections:(NSArray <id<DFITableViewSection>> *)sections;

- (UITableViewCell *)tableView:(UITableView *)tableView dataSourceCellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSUInteger)count;

- (NSArray <NSArray *> *)rawArray;

@end

@interface DFITableViewDataSource (IndexedSubscript)

- (id)objectAtIndexedSubscript:(NSUInteger)idx;

@end

@interface DFITableViewDataSource (Operations)

- (void)addSection:(id<DFITableViewSection>)section;
- (void)addSections:(NSArray <id<DFITableViewSection>> *)sections;

@end

NS_ASSUME_NONNULL_END
