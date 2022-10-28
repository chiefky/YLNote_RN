//
//  YLThreadBlockOperationController.m
//  YLNote
//
//  Created by tangh on 2022/2/21.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLThreadBlockOperationController.h"
#import "YLThread.h"

@implementation YLThreadBlockOperationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - actions
- (void)doThreadAction {
    
}
#pragma mark - funcs
/// NSBlockOperation基本使用
- (void)testOperation_block_usage {
    NSLog(@"🌈 %@ begin: %@", NSStringFromSelector(_cmd),[NSThread currentThread]);
    NSBlockOperation *op =  [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1/3 %@ Start, mainThread(33): %@, currentThread(%ld): %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread].qualityOfService,[NSThread currentThread]);
        sleep(10);
        NSLog(@"1/3 Finish executing .");
    }];
    NSLog(@"😄服务质量：%ld",op.qualityOfService);
    [op addExecutionBlock:^{
        NSLog(@"2/3 %@ Start, mainThread(33): %@, currentThread(%ld): %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread].qualityOfService,[NSThread currentThread]);
        sleep(3);
        NSLog(@"2/3 Finish executing .");
    }];
    [op addExecutionBlock:^{
        NSLog(@"3/3 %@ Start, mainThread(33): %@, currentThread(%ld): %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread].qualityOfService,[NSThread currentThread]);
        sleep(30);
        NSLog(@"3/3 Finish executing .");
    }];
    
    // 回调监听（completionBlock是异步的，使用任务都执行完才会回调）
    op.completionBlock = ^{
        NSLog(@" operation完成了: %@", [NSThread currentThread]);
    };
    // 3个block是并行执行的，所以他们的完成顺序不确定
    // 因为 NSBlockOperation 的 isAsynchronous 默认是NO，所以会阻塞 start 方法后的任务，直到所有 block 都完成，🌈 over才会打印
    [op start];
    NSLog(@"🌈 %@ over: %@", NSStringFromSelector(_cmd),[NSThread currentThread]);
}

/// 使用queue管理多个NSBlockOperation任务
- (void)testOperation_block_queue {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //    queue.maxConcurrentOperationCount = 1; // 自定义queue的maxConcurrentOperationCount默认值是-1，代表是并发队列
    NSBlockOperation *op1 =  [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"♥️1/1 %@ Start, mainThread(33): %@, currentThread(%ld): %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread].qualityOfService,[NSThread currentThread]);
        sleep(3);
        NSLog(@"♥️1/1 %@ Finish executing .", NSStringFromSelector(_cmd));
    }];
    [op1 addExecutionBlock:^{
        NSLog(@"♥️1/2 %@ Start, mainThread(33): %@, currentThread(%ld): %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread].qualityOfService,[NSThread currentThread]);
        sleep(3);
        NSLog(@"♥️1/2 %@ Finish executing .", NSStringFromSelector(_cmd));
    }];
    [op1 addExecutionBlock:^{
        NSLog(@"♥️/3 %@ Start, mainThread(33): %@, currentThread(%ld): %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread].qualityOfService,[NSThread currentThread]);
        sleep(3);
        NSLog(@"♥️1/3 %@ Finish executing .", NSStringFromSelector(_cmd));
    }];
    NSBlockOperation *op2 =  [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"🍊2 %@ Start, mainThread(33): %@, currentThread(%ld): %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread].qualityOfService,[NSThread currentThread]);
        sleep(3);
        NSLog(@"🍊2 %@ Finish executing .", NSStringFromSelector(_cmd));
    }];
    NSBlockOperation *op3 =  [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"🍎3 %@ Start, mainThread(33): %@, currentThread(%ld): %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread].qualityOfService,[NSThread currentThread]);
        sleep(3);
        NSLog(@"🍎3 %@ Finish executing .", NSStringFromSelector(_cmd));
    }];
    NSBlockOperation *op4 =  [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"🍓4 %@ Start, mainThread(33): %@, currentThread(%ld): %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread].qualityOfService,[NSThread currentThread]);
        sleep(3);
        NSLog(@"🍓4 %@ Finish executing .", NSStringFromSelector(_cmd));
    }];
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
}

/// 多线程任务同步
- (void)testOperation_block_sync {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *op1 =  [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"♥️1/1 %@ Start, mainThread(33): %@, currentThread(%ld): %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread].qualityOfService,[NSThread currentThread]);
        sleep(3);
        NSLog(@"♥️1/1 %@ Finish executing .", NSStringFromSelector(_cmd));
    }];
    [op1 addExecutionBlock:^{
        NSLog(@"♥️1/2 %@ Start, mainThread(33): %@, currentThread(%ld): %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread].qualityOfService,[NSThread currentThread]);
        sleep(3);
        NSLog(@"♥️1/2 %@ Finish executing .", NSStringFromSelector(_cmd));
    }];
    [op1 addExecutionBlock:^{
        NSLog(@"♥️1/3 %@ Start, mainThread(33): %@, currentThread(%ld): %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread].qualityOfService,[NSThread currentThread]);
        sleep(3);
        NSLog(@"♥️1/3 %@ Finish executing .", NSStringFromSelector(_cmd));
    }];
    NSBlockOperation *syncOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"可以更新界面啦~~~");
    }];
    
    [syncOp addDependency:op1];
    
    [queue addOperation:op1];
    [queue addOperation:syncOp];

}

#pragma mark - override
- (NSString *)fileName {
    return @"thread_operation_block";
}


@end
