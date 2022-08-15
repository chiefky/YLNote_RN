//
//  NSTimer+SafeBlock.h
//  YLNote
//
//  Created by tangh on 2022/8/15.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (SafeBlock)

+ (instancetype)yl_ScheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats block:
(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
