//
//  YLGCDQueueAndSyncGrupTableController.m
//  YLNote
//
//  Created by tangh on 2021/10/19.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLThreadAsyncQueueGroupController.h"
#import "YLNoteData.h"

@interface YLThreadAsyncQueueGroupController ()

@end

@implementation YLThreadAsyncQueueGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)testGCD_usage {
//  1.  创建队列
    dispatch_queue_t m_queue = dispatch_get_main_queue(); // 主队列
    dispatch_queue_t g_queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0); // 全局队列
    dispatch_queue_t s_queue = dispatch_queue_create("queue.yuli.serial", DISPATCH_QUEUE_SERIAL); // 串行队列
    dispatch_queue_t c_queue = dispatch_queue_create("queue.yuli.concurrent", DISPATCH_QUEUE_CONCURRENT); // 并发队列
    

//  2.  添加任务
    dispatch_sync(s_queue, ^{
        NSLog(@"这是一个同步任务 1,%@",[NSThread currentThread]);
    });
    dispatch_sync(s_queue, ^{
        NSLog(@"这是一个同步任务 2,%@",[NSThread currentThread]);
    });
    dispatch_sync(s_queue, ^{
        NSLog(@"这是一个同步任务 3,%@",[NSThread currentThread]);
    });
    dispatch_sync(s_queue, ^{
        NSLog(@"这是一个同步任务 4,%@",[NSThread currentThread]);
    });

    dispatch_async(s_queue, ^{
        NSLog(@"这是一个异步任务 1,%@",[NSThread currentThread]);
    });
    dispatch_async(s_queue, ^{
        NSLog(@"这是一个异步任务 2,%@",[NSThread currentThread]);
    });
    dispatch_async(s_queue, ^{
        NSLog(@"这是一个异步任务 3,%@",[NSThread currentThread]);
    });
    dispatch_async(s_queue, ^{
        NSLog(@"这是一个异步任务 4,%@",[NSThread currentThread]);
    });

}
#pragma mark - (普通场景) 串行队列
/// 同步任务
- (void)testSerial_sync {
    NSLog(@"同步任务+串行队列---start");

    dispatch_queue_t queue = dispatch_queue_create("queue.yuli.seria", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"同步任务+串行队列---end");
}

/// 异步任务
- (void)testSerial_async {
    NSLog(@"异步任务+串行队列---start");

    dispatch_queue_t queue = dispatch_queue_create("queue.yuli.seria", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        // 追加任务 1
        NSLog(@"1 begin：%@",[NSThread currentThread]);      // 打印当前线程

        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 2
        NSLog(@"2 begin：%@",[NSThread currentThread]);      // 打印当前线程

        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 3
        NSLog(@"3 begin：%@",[NSThread currentThread]);      // 打印当前线程

        [NSThread sleepForTimeInterval:2];
        // 模拟耗时操作
        NSLog(@"3 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"异步任务+串行队列---end");
}

#pragma mark - (普通场景) 并发队列
/// 同步任务
- (void)testConcurrent_sync {
    NSLog(@"同步任务+并发队列---start");

    dispatch_queue_t queue = dispatch_queue_create("queue.yuli.concurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
    NSLog(@"同步任务+并发队列---end");
}

/// 异步任务
- (void)testConcurrent_async {
    NSLog(@"异步任务+并发队列---start");

    dispatch_queue_t queue = dispatch_queue_create("queue.yuli.concurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
        
    NSLog(@"异步任务+并发队列---end");
}

#pragma mark-主队列

/// 同步任务+主队列
- (void)testSync_main {
    NSLog(@"同步任务+主队列---start");

    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"同步任务+主队列---end");
}

/// 异步任务+主队列
- (void)testAsync_main {
    NSLog(@"异步任务+主队列---start");

    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        // 追加任务 1
        NSLog(@"1 begin：%@",[NSThread currentThread]);      // 打印当前线程

        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 2
        NSLog(@"2 begin：%@",[NSThread currentThread]);      // 打印当前线程

        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 3
        NSLog(@"3 begin：%@",[NSThread currentThread]);      // 打印当前线程

        [NSThread sleepForTimeInterval:2];
        // 模拟耗时操作
        NSLog(@"3 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"异步任务+主队列---end");
}

#pragma mark - (嵌套场景) 串行队列
/// 【同步】嵌【同步】
- (void)testSerial_sync_nest_sync {
    NSLog(@"串行队列:【同步】嵌【同步】---start");

    dispatch_queue_t queue = dispatch_queue_create("queue.yuli.seria", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        // 追加任务 1
        NSLog(@"1 begin：%@",[NSThread currentThread]);      // 打印当前线程

        dispatch_sync(queue, ^{
            // 追加任务 2
            NSLog(@"2 begin：%@",[NSThread currentThread]);      // 打印当前线程
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2 end：%@",[NSThread currentThread]);      // 打印当前线程
        });

        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    
    dispatch_sync(queue, ^{
        // 追加任务 3
        NSLog(@"3 begin：%@",[NSThread currentThread]);      // 打印当前线程

        [NSThread sleepForTimeInterval:2];
        // 模拟耗时操作
        NSLog(@"3 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"串行队列:【同步】嵌【同步】---over");
}

/// 【同步】嵌【异步】
- (void)testSerial_sync_nest_async {
    NSLog(@"串行队列:【同步】嵌【异步】---start");

    dispatch_queue_t queue = dispatch_queue_create("queue.yuli.seria", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        // 追加任务 1
        NSLog(@"1 begin：%@",[NSThread currentThread]);      // 打印当前线程
     
        dispatch_async(queue, ^{
            // 追加任务 2
            NSLog(@"2 begin：%@",[NSThread currentThread]);      // 打印当前线程

            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2 end：%@",[NSThread currentThread]);      // 打印当前线程
        });

        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"追加3任务");
    dispatch_sync(queue, ^{
        // 追加任务 3
        NSLog(@"3 begin：%@",[NSThread currentThread]);      // 打印当前线程

        [NSThread sleepForTimeInterval:2];
        // 模拟耗时操作
        NSLog(@"3 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"串行队列:【同步】嵌【异步】---over");
}
/// 【异步】嵌【同步】
- (void)testSerial_async_nest_sync {
    NSLog(@"串行队列:【异步】嵌【同步】---start");

    dispatch_queue_t queue = dispatch_queue_create("queue.yuli.seria", DISPATCH_QUEUE_SERIAL);
    NSLog(@"①进入queue");
    dispatch_async(queue, ^{
        // 追加任务 1
        NSLog(@"1 begin：%@",[NSThread currentThread]);      // 打印当前线程
        NSLog(@"②进入queue");
        dispatch_sync(queue, ^{
            // 追加任务 2
            NSLog(@"2 begin：%@",[NSThread currentThread]);      // 打印当前线程

            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2 end：%@",[NSThread currentThread]);      // 打印当前线程
        });
        
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    NSLog(@"③进入queue");
    dispatch_async(queue, ^{
        // 追加任务 3
        NSLog(@"3 begin：%@",[NSThread currentThread]);      // 打印当前线程

        [NSThread sleepForTimeInterval:2];
        // 模拟耗时操作
        NSLog(@"3 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    NSLog(@"串行队列:【异步】嵌【同步】---over");
}

///// 【异步】嵌【异步】
- (void)testSerial_async_nest_async {
    NSLog(@"串行队列:【异步】嵌【异步】---start");

    dispatch_queue_t queue = dispatch_queue_create("queue.yuli.seria", DISPATCH_QUEUE_SERIAL);
    NSLog(@"①进入queue，%@",queue);
    dispatch_async(queue, ^{
        // 追加任务 1
        NSLog(@"1 begin：%@",[NSThread currentThread]);      // 打印当前线程
        NSLog(@"②进入queue，%@",queue);
        dispatch_async(queue, ^{
            // 追加任务 2
            NSLog(@"2 begin：%@",[NSThread currentThread]);      // 打印当前线程

            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2 end：%@",[NSThread currentThread]);      // 打印当前线程
        });
        NSLog(@"②'' 进入queue，%@",queue);

        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    NSLog(@"③进入queue，%@",queue);
    dispatch_async(queue, ^{
        // 追加任务 3
        NSLog(@"3 begin：%@",[NSThread currentThread]);      // 打印当前线程

        [NSThread sleepForTimeInterval:2];
        // 模拟耗时操作
        NSLog(@"3 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    NSLog(@"③'' 进入queue，%@",queue);

    NSLog(@"串行队列:【异步】嵌【异步】---over");
}
#pragma mark - (嵌套场景) 并发队列
/// 【同步】嵌【同步】
- (void)testConcurrent_sync_nest_sync {
    NSLog(@"并发队列:【同步】嵌【同步】---start");

    dispatch_queue_t queue = dispatch_queue_create("queue.yuli.concurrent", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"①进入queue");
    dispatch_sync(queue, ^{
        // 追加任务 1
        NSLog(@"1 begin：%@",[NSThread currentThread]);      // 打印当前线程
        NSLog(@"②进入queue");
        dispatch_sync(queue, ^{
            // 追加任务 2
            NSLog(@"2 begin：%@",[NSThread currentThread]);      // 打印当前线程

            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2 end：%@",[NSThread currentThread]);      // 打印当前线程
        });

        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"③进入queue");
    dispatch_sync(queue, ^{
        // 追加任务 3
        NSLog(@"3 begin：%@",[NSThread currentThread]);      // 打印当前线程

        [NSThread sleepForTimeInterval:2];
        // 模拟耗时操作
        NSLog(@"3 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"并发队列:【同步】嵌【同步】---over");
}

/// 【同步】嵌【异步】
- (void)testConcurrent_sync_nest_async {
    NSLog(@"并发队列:【同步】嵌【异步】---start");

    dispatch_queue_t queue = dispatch_queue_create("queue.yuli.concurrent", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"①进入queue");
    dispatch_sync(queue, ^{
        // 追加任务 1
        NSLog(@"1 begin：%@",[NSThread currentThread]);      // 打印当前线程
        NSLog(@"②进入queue");
        dispatch_async(queue, ^{
            // 追加任务 2
            NSLog(@"2 begin：%@",[NSThread currentThread]);      // 打印当前线程

            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2 end：%@",[NSThread currentThread]);      // 打印当前线程
        });

        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"③进入queue");
    dispatch_sync(queue, ^{
        // 追加任务 3
        NSLog(@"3 begin：%@",[NSThread currentThread]);      // 打印当前线程

        [NSThread sleepForTimeInterval:2];
        // 模拟耗时操作
        NSLog(@"3 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"并发队列:【同步】嵌【异步】---over");
}

/// 【异步】嵌【同步】
- (void)testConcurrent_async_nest_sync {
    NSLog(@"并发队列:【异步】嵌【同步】---start");
    dispatch_queue_t queue = dispatch_queue_create("queue.yuli.concurrent", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"①进入queue");
    dispatch_async(queue, ^{
        // 追加任务 1
        NSLog(@"1 begin：%@",[NSThread currentThread]);      // 打印当前线程
        NSLog(@"②进入queue");
        dispatch_sync(queue, ^{
            // 追加任务 2
            NSLog(@"2 begin：%@",[NSThread currentThread]);      // 打印当前线程

            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2 end：%@",[NSThread currentThread]);      // 打印当前线程
        });
        
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    NSLog(@"③进入queue");
    dispatch_async(queue, ^{
        // 追加任务 3
        NSLog(@"3 begin：%@",[NSThread currentThread]);      // 打印当前线程

        [NSThread sleepForTimeInterval:2];
        // 模拟耗时操作
        NSLog(@"3 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"并发队列:【异步】嵌【同步】---over");
}

/// 【异步】嵌【异步】
- (void)testConcurrent_async_nest_async {
    NSLog(@"并发队列:【异步】嵌【异步】---start");

    dispatch_queue_t queue = dispatch_queue_create("queue.yuli.concurrent", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"①进入queue");
    dispatch_async(queue, ^{
        // 追加任务 1
        NSLog(@"1 begin：%@",[NSThread currentThread]);      // 打印当前线程
        NSLog(@"②进入queue");
        dispatch_async(queue, ^{
            // 追加任务 2
            NSLog(@"2 begin：%@",[NSThread currentThread]);      // 打印当前线程

            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2 end：%@",[NSThread currentThread]);      // 打印当前线程
        });
        
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    NSLog(@"③进入queue");
    dispatch_async(queue, ^{
        // 追加任务 3
        NSLog(@"3 begin：%@",[NSThread currentThread]);      // 打印当前线程

        [NSThread sleepForTimeInterval:2];
        // 模拟耗时操作
        NSLog(@"3 end：%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"并发队列:【异步】嵌【异步】---over");
}


#pragma mark - cell data
- (NSString *)fileName {
    return @"thread_async_queue";
}


@end
