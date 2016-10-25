//
//  DFIUITableViewDelegateProxy.m
//  DFInfrastructure
//
//  Created by SDH on 4/16/16.
//  Copyright © 2016 com.dazhongcun. All rights reserved.
//

#import "DFIUITableViewDelegateProxy.h"

#import "DFITableViewConfigurationInternal.h"

#import <UIKit/UIKit.h>

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
#import <ReactiveCocoa/ReactiveCocoa.h>
#endif

@interface DFIUITableViewDelegateProxy () <UITableViewDelegate>

@property (nonatomic, weak) id<DFITableViewConfigurationInternal> tableViewConfiguration;

@end

@implementation DFIUITableViewDelegateProxy

- (instancetype)initWithTableViewConfiguration:(id<DFITableViewConfigurationInternal>)tableViewConfiguration {
    self = [super init];
    
    if (self) {
        _tableViewConfiguration = tableViewConfiguration;
        _tableViewConfiguration.tableView.delegate = self;
        
#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
        _tableViewConfiguration.selectRowSignal = self.selectRowSignal;
#endif
    }
    
    return self;
}

#pragma mark -
#pragma mark - UITableViewDelegate;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            
        return [self.tableViewConfiguration.tableViewDelegate tableView:tableView
                                                heightForRowAtIndexPath:indexPath];
    }
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
            
        [self.tableViewConfiguration.tableViewDelegate tableView:tableView
                                estimatedHeightForRowAtIndexPath:indexPath];
    }
    
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
            
        return [self.tableViewConfiguration.tableViewDelegate tableView:tableView
                                               heightForHeaderInSection:section];
    }
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
            
        return [self.tableViewConfiguration.tableViewDelegate tableView:tableView
                                               heightForFooterInSection:section];
    }
    
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            
        return [self.tableViewConfiguration.tableViewDelegate tableView:tableView
                                                didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
                                         forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        
        [self.tableViewConfiguration.tableViewDelegate tableView:tableView
                                                 willDisplayCell:cell
                                               forRowAtIndexPath:indexPath];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(scrollViewDidScroll:)]) {
        
        [self.tableViewConfiguration.tableViewDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(scrollViewDidZoom:)]) {
            
        [self.tableViewConfiguration.tableViewDelegate scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
            
        [self.tableViewConfiguration.tableViewDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
            
            [self.tableViewConfiguration.tableViewDelegate scrollViewWillEndDragging:scrollView
                                                                        withVelocity:velocity
                                                                 targetContentOffset:targetContentOffset];
        }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
            
        [self.tableViewConfiguration.tableViewDelegate scrollViewDidEndDragging:scrollView
                                                                 willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
            
        [self.tableViewConfiguration.tableViewDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
            
        [self.tableViewConfiguration.tableViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
            
        [self.tableViewConfiguration.tableViewDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
            
        return [self.tableViewConfiguration.tableViewDelegate viewForZoomingInScrollView:scrollView];
    }
    
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView
                          withView:(nullable UIView *)view {
    
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
            
        [self.tableViewConfiguration.tableViewDelegate scrollViewWillBeginZooming:scrollView
                                                                         withView:view];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
            
            [self.tableViewConfiguration.tableViewDelegate
             scrollViewDidEndZooming:scrollView
             withView:view
             atScale:scale];
        }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
            
        return [self.tableViewConfiguration.tableViewDelegate scrollViewShouldScrollToTop:scrollView];
    }
    
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (self.tableViewConfiguration.tableViewDelegate &&
        [self.tableViewConfiguration.tableViewDelegate
         respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
            
        [self.tableViewConfiguration.tableViewDelegate scrollViewDidScrollToTop:scrollView];
    }
}

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
- (RACSignal *)selectRowSignal {
    
    return [self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:)
                          fromProtocol:@protocol(UITableViewDelegate)];;
}
#endif

@end
