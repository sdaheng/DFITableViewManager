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

@protocol DFITableViewRowInfo <NSObject>

- (id)info;

@end

@protocol DFITableViewRow <NSObject>

@property (readonly, nonatomic, strong) NSIndexPath *indexPath;

+ (id<DFITableViewRow>)rowWithInfo:(id)info;

- (id<DFITableViewRowInfo>)info;

@end

@protocol DFITableViewSection <NSObject, NSFastEnumeration>

@property (readonly, nonatomic, assign) NSUInteger index;

+ (instancetype)sectionWithRows:(NSArray<id<DFITableViewRow>>*)rows;

- (NSArray <id<DFITableViewRow>> *)rows;

- (void)addRows:(NSArray <id<DFITableViewRow>> *)rows;

- (NSUInteger)count;

@end

NS_ASSUME_NONNULL_BEGIN

@interface DFITableViewRow : NSObject <DFITableViewRow>

@end

@interface DFITableViewViewModelSection : NSObject <DFITableViewSection>

@end

@interface DFITableViewDictionarySection : NSObject <DFITableViewSection>

@property (nonatomic, assign) BOOL rowConfigurationIsSameInSection;

@end

@interface DFITableViewDataSource : NSObject <NSFastEnumeration>

@property (nonatomic, copy, nullable) NSDictionary <NSString *, NSDictionary *> *dataSourceFormat;

@property (nonatomic, copy) DFITableViewCellOptionBlock optionBlock;

+ (instancetype)dataSourceWithRawSectionsAndRows:(NSArray <NSArray *> *)dataSource;
+ (instancetype)dataSourceWithFormat:(NSDictionary <NSString *, NSDictionary *>*)dataSourceFormat;

+ (instancetype)dataSourceWithSections:(NSArray <id<DFITableViewSection>> *)sections;

- (UITableViewCell *)tableView:(UITableView *)tableView dataSourceCellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray <id<DFITableViewSection>> *)allSections;

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

@interface DFITableViewCellViewModel (RowInfo) <DFITableViewRowInfo>
@end

@interface NSDictionary (RowInfo) <DFITableViewRowInfo>
@end

NS_ASSUME_NONNULL_END
