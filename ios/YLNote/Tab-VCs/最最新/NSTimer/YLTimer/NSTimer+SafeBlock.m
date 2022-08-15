//
//  NSTimer+SafeBlock.m
//  YLNote
//
//  Created by tangh on 2022/8/15.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "NSTimer+SafeBlock.h"

@implementation NSTimer (SafeBlock)

+ (instancetype)yl_ScheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats block:(void (^)(void))block {
    return [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(handle:) userInfo:[block copy] repeats:repeats];
}

+ (void)handle:(NSTimer *)timer {
    void(^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}

@end
