//
//  YLThreadGCDDispatchQueueController.m
//  YLNote
//
//  Created by tangh on 2021/11/10.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLThreadGCDDispatchQueueController.h"


@interface YLThreadGCDDispatchQueueController ()

@property(nonatomic,strong) dispatch_queue_t myqueue;

@end

@implementation YLThreadGCDDispatchQueueController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/// 开启任务
- (void)testGCD_queue_start {
    for (NSUInteger i = 0; i<10; i++) {
        dispatch_async(self.myqueue, ^{
            NSLog(@"Hello %ld",i);
            sleep(1);
        });
    }
}

/// "挂起队列"
- (void)testGCD_queue_suspend {
    NSLog(@"挂起队列");
    dispatch_suspend(self.myqueue);
}

/// "恢复队列"
- (void)testGCD_queue_resume {
    NSLog(@"恢复队列");
    dispatch_resume(self.myqueue);
}

/// 不同队列任务同步（慎用）
- (void)testGCD_queue_setTarget {
    dispatch_queue_t targetQueue = dispatch_queue_create("yuli.target.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t queue_1 = dispatch_queue_create("test.1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue_2 = dispatch_queue_create("test.2", DISPATCH_QUEUE_SERIAL);

    dispatch_set_target_queue(queue_1, targetQueue);
    dispatch_set_target_queue(queue_2, targetQueue);
    
    dispatch_async(queue_1, ^{
        NSLog(@"A in %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"A out");
    });


    dispatch_async(queue_1, ^{
        NSLog(@"B in %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"B out");
    });

    dispatch_async(queue_2, ^{
        NSLog(@"C in %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"C out");
        
    });
    
    dispatch_async(queue_2, ^{
        NSLog(@"D in %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"D out");
        
    });

    dispatch_barrier_async(targetQueue, ^{
        NSLog(@"barrier in %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"barrier out");
    });
    
    dispatch_async(targetQueue, ^{
        NSLog(@"M in %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"M out");

    });
    
}

/// 改变队列层级体系（慎用）
- (void)testGCD_queue_setTarget2 {
    dispatch_queue_t targetQueue = dispatch_queue_create("yuli.target.queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t queue_1 = dispatch_queue_create("test.1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue_2 = dispatch_queue_create("test.2", DISPATCH_QUEUE_CONCURRENT);

    dispatch_set_target_queue(queue_1, targetQueue);
    dispatch_set_target_queue(queue_2, targetQueue);
    
    dispatch_async(queue_1, ^{
        NSLog(@"A in %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"A out");
    });


    dispatch_async(queue_1, ^{
        NSLog(@"B in %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"B out");
    });

    dispatch_async(queue_2, ^{
        NSLog(@"C in %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"C out");
        
    });
    
    dispatch_async(queue_2, ^{
        NSLog(@"D in %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"D out");
        
    });
    
    dispatch_async(targetQueue, ^{
        NSLog(@"M in %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"M out");

    });
    
}
- (void)testGCD_queue_after {
    NSLog(@"Hello world---0");
    dispatch_queue_t q = dispatch_queue_create("yuli.target.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (1*NSEC_PER_SEC)), q, ^{
        NSLog(@"1秒后执行");
    });
}

/// 快速迭代
- (void)testGCD_queue_apply {
    dispatch_queue_attr_t attr_t = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT,  QOS_CLASS_UTILITY, QOS_MIN_RELATIVE_PRIORITY);
    dispatch_queue_t queue = dispatch_queue_create("yuli.target.queue", attr_t);
    dispatch_apply(10, queue, ^(size_t idx) {
        NSLog(@"😭%@--[%ld,%u] --> 第%@只【嘤嘤怪👶🏻】向你奔来...", [NSThread currentThread],[NSThread currentThread].qualityOfService,dispatch_queue_get_qos_class(queue, nil),@(idx+1));
    });
}

#pragma mark -lazy cell data
- (dispatch_queue_t)myqueue {
    if (!_myqueue) {
        _myqueue = dispatch_queue_create("com.yuli.gcd.thread", DISPATCH_QUEUE_SERIAL);
    }
    return _myqueue;
}

- (NSString *)fileName {
    return @"thread_gcd_queue";
}

@end
