//
//  DFITableViewHeightCache.m
//  Pods
//
//  Created by SDH on 10/04/2017.
//
//

#import "DFITableViewHeightCache.h"

@interface DFITableViewHeightCacheItem : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign, getter=isDirty) BOOL dirty;

@end

@implementation DFITableViewHeightCacheItem

- (BOOL)isDirty {
    return _dirty;
}

@end

@interface DFITableViewHeightCache()

@property (nonatomic, strong) NSMutableDictionary <NSString *, DFITableViewHeightCacheItem *> *cache;

@end

@implementation DFITableViewHeightCache

- (CGFloat)cachedHeightAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:@"%@-%@", @(indexPath.section), @(indexPath.row)];
    return self.cache[key].height;
}

- (BOOL)itemIsCachedAtIndexPath:(NSIndexPath *)indexPath {
    return [self itemInCacheAtIndexPath:indexPath] != nil;
}

- (DFITableViewHeightCacheItem *)itemInCacheAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:@"%@-%@", @(indexPath.section), @(indexPath.row)];

    return self.cache[key];
}

- (void)cacheForIdentifier:(NSString *)identifier
                        at:(NSIndexPath *)indexPath
                withHeight:(CGFloat)height {
    
    if ([self itemIsCachedAtIndexPath:indexPath] && [self itemInCacheAtIndexPath:indexPath].isDirty) {
        
    }
    DFITableViewHeightCacheItem *item = [[DFITableViewHeightCacheItem alloc] init];
    
    item.identifier = identifier;
    item.indexPath = indexPath;
    item.height = height;
    
    NSString *key = [NSString stringWithFormat:@"%@-%@", @(indexPath.section), @(indexPath.row)];
    
    self.cache[key] = item;
}

- (NSMutableDictionary *)cache {
    if (!_cache) {
        _cache = [NSMutableDictionary dictionary];
    }
    
    return _cache;
}

@end
