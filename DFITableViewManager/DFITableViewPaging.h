
//
//  DFITableViewPaging.h
//  DFInfrastructure
//
//  Created by SDH on 4/12/16.
//  Copyright © 2016 com.dazhongcun. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
#import <ReactiveCocoa/ReactiveCocoa.h>
#endif

@protocol DFITableViewPaging <NSObject>

@property (nonatomic, assign) NSInteger pageNumber;

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
//@property (nonatomic, strong) RACSignal *refreshSignal;
//@property (nonatomic, strong) RACSignal *loadMoreSignal;
#endif


@end
