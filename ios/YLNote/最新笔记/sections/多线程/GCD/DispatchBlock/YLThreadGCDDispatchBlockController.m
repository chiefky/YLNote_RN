//
//  YLThreadGCDDispatchBlockController.m
//  YLNote
//
//  Created by tangh on 2021/11/5.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLThreadGCDDispatchBlockController.h"

@interface YLThreadGCDDispatchBlockController ()

@end

@implementation YLThreadGCDDispatchBlockController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - create
/// 通过语法糖创建的block未捕获外部变量是在栈上的，通过 dispatch_block_create 方法可以使block 创建在堆上
- (void)testGCD_block_create {
    dispatch_queue_t queue = dispatch_queue_create("com.yuli.gcd.thread", DISPATCH_QUEUE_SERIAL);
    //创建一个 block
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSLog(@"%s:Hello world!",dispatch_queue_get_label(queue));
    });
    dispatch_async(queue, block);
}
#pragma mark - create_qos
/// 创建一个带有 QoS 的 block，指定 block 的优先级。
- (void)testGCD_block_create_qos {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_block_t bk_background = dispatch_block_create_with_qos_class(0, QOS_CLASS_BACKGROUND, -1, ^{
            NSLog(@"BackGroundBlock");
    });
    dispatch_block_t bk_userInitiated = dispatch_block_create_with_qos_class(0, QOS_CLASS_USER_INITIATED, -1, ^{
            NSLog(@"UserInitiatedBlock");
    });
    for (int i = 0; i < 3; i++) {
        dispatch_async(queue, bk_background);
        dispatch_async(queue, bk_userInitiated);
    }
}
#pragma mark - notify
/// block1执行完后将block2加入队列
- (void)testGCD_block_notify {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t block1 = dispatch_block_create(0, ^{
        NSLog(@"block1 begin");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"block1 done");
    });

    dispatch_async(queue, block1);
    dispatch_block_t block5 = dispatch_block_create(0, ^{
        NSLog(@"有点appdency的感觉😄😁");
    });
    //当block1执行完毕后，提交block2到global queue中执行
    dispatch_block_notify(block1, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block5);
    NSLog(@"dispatch_block_notify 后面");

}
#pragma mark - wait
/**
 同步等待，直到指定的 block 执行完成或指定的超时时间结束为止才返回；
 设置等待时间 DISPATCH_TIME_NOW 会立刻返回，
 设置 DISPATCH_TIME_FOREVER 会无限期等待指定的 block 执行完成才返回。
 */
- (void)testGCD_block_wait {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSLog(@"begin %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:5];
        NSLog(@"end %@",[NSThread currentThread]);
    });
    dispatch_async(queue, block);
    //等待前面的任务执行完毕
    dispatch_time_t interval = DISPATCH_TIME_FOREVER; // dispatch_time(DISPATCH_TIME_NOW, 4);
   long result = dispatch_block_wait(block, interval);
    NSLog(@"coutinue res:%ld %@",result,[NSThread currentThread]);
}

#pragma mark - cancel
/// 异步取消指定的 block，正在执行的 block 不会被取消。
- (void)testGCD_block_cancel {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t block1 = dispatch_block_create(0, ^{
        NSLog(@"block1 begin");
        [NSThread sleepForTimeInterval:5];
        NSLog(@"block1 done");
    });
    dispatch_block_t block2 = dispatch_block_create(0, ^{
        NSLog(@"block2");
    });
    dispatch_block_t block3 = dispatch_block_create(0, ^{
        NSLog(@"block3");
    });
    dispatch_block_t bk_userInitiated = dispatch_block_create_with_qos_class(0, QOS_CLASS_USER_INITIATED, -1, ^{
            NSLog(@"UserInitiatedBlock");
    });

    dispatch_async(queue, block1);
    dispatch_async(queue, block2);
    dispatch_async(queue, block3);
    //取消block2
    dispatch_block_cancel(block2);
    //测试block2是否被取消 ,"测试指定的 block 是否被取消。返回非0代表已被取消；返回0代表没有取消"
    NSLog(@"block2是否被取消:%ld",dispatch_block_testcancel(block2));

}
#pragma mark - perform
- (void)testGCD_block_perform {
    
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"block1 begin:%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:5];
        NSLog(@"block1 done:%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"block2 begin:%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:5];
        NSLog(@"block2 done:%@",[NSThread currentThread]);

    });
    dispatch_block_t bk_userInitiated = dispatch_block_create_with_qos_class(0, QOS_CLASS_USER_INITIATED, -1, ^{
          
        NSLog(@"🍎 UserInitiatedBlock begin:%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:5];
        NSLog(@"🍎 UserInitiatedBlock done:%@",[NSThread currentThread]);

    });
    dispatch_async(queue, bk_userInitiated);
    
    dispatch_block_perform(DISPATCH_BLOCK_DETACHED, ^{
        NSLog(@"dispatch_block_perform  Hello:%@",[NSThread currentThread]);
    });

}

#pragma mark - cell data
- (NSString *)fileName {
    return @"thread_gcd_block";
}


@end
