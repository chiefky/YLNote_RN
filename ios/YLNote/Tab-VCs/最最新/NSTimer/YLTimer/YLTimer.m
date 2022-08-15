//
//  YLTimer.m
//  YLNote
//
//  Created by tangh on 2022/8/15.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLTimer.h"

@interface YLTimer ()

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation YLTimer

- (void)startTimerWithInterval:(NSTimeInterval)inteval {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:inteval target:self selector:@selector(doWork:) userInfo:nil repeats:YES];
}

- (void)doWork:(id)sender {
    NSLog(@"%p : %@",sender,[NSDate date]);
}

- (void)stopTimer {
    if (!self.timer) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
}
@end
