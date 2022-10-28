//
//  YLThreadGCDDispatchBarrierController.m
//  YLNote
//
//  Created by tangh on 2021/11/9.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLThreadGCDDispatchBarrierController.h"

@interface YLThreadGCDDispatchBarrierController ()

@end

@implementation YLThreadGCDDispatchBarrierController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 当多线程并发读写同一个资源时，为了保证资源读写的正确性，可以用Barrier Block解决该问题。
 Dispatch Barrier会确保队列中先于Barrier Block提交的任务都完成后再执行它，并且执行时队列不会同步执行其它任务，等Barrier Block执行完成后再开始执行其他任务。代码示例如下：
 */
- (void)testBarrier_create {
    //创建自定义并行队列
    dispatch_queue_t queue = dispatch_queue_create("com.yuli.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        //读操作
        sleep(6);
        NSLog(@"work1");
    });
    dispatch_async(queue, ^{
        //读操作
        NSLog(@"work2");
    });
    dispatch_barrier_async(queue, ^{
        //barrier block,可用于写操作
        //确保资源更新过程中不会有其他线程读取
        sleep(5);
        NSLog(@"work3");
    });
    dispatch_async(queue, ^{
        //读操作
        sleep(2);

        NSLog(@"read all 1");
    });
    dispatch_async(queue, ^{
        //读操作
        NSLog(@"read all 2");
    });

}

#pragma mark - cell data
- (NSString *)fileName {
    return @"thread_gcd_barrier";
}


@end
