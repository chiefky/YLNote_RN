//
//  YLThreadInvocationOperationController.m
//  YLNote
//
//  Created by tangh on 2022/2/21.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLThreadInvocationOperationController.h"

@interface YLThreadInvocationOperationController ()

@end

@implementation YLThreadInvocationOperationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - actions
- (void)taskMethod1:(id) data {
    NSLog(@"🍎 %@ Start executing, with data: %@, mainThread(33): %@, currentThread(%ld): %@", NSStringFromSelector(_cmd), data, [NSThread mainThread],[NSThread currentThread].qualityOfService, [NSThread currentThread]);
    sleep(3);
    NSLog(@"🍎 %@ Finish executing 。", NSStringFromSelector(_cmd));
}

- (void)taskMethod2 {
    NSLog(@"🍓 %@ Start executing , mainThread(33): %@, currentThread(%ld): %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread].qualityOfService,[NSThread currentThread]);
    sleep(3);
    NSLog(@"🍓 %@ Finish executing .", NSStringFromSelector(_cmd));

}

- (void)taskMethod3:(NSNumber *) index {
    [[NSThread currentThread] setName:[NSString stringWithFormat:@"thread.pig.%@",index]];
    NSLog(@" 🍊 %@: %@ Start, main【33,%@】: , current【%ld,%@】",index, NSStringFromSelector(_cmd), [NSThread mainThread].name,[NSThread currentThread].qualityOfService, [NSThread currentThread]);
    sleep(3);
    NSLog(@" 🍊 %@: %@ Finish。",index, NSStringFromSelector(_cmd));
}


#pragma mark - funcs

/// NSInvocationOperation基本使用
- (void)testOperation_invocation_usage {
    NSString *data = @"Hello world!---1";
    NSInvocationOperation *op =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod1:) object:data];
    op.qualityOfService = NSQualityOfServiceBackground;
    NSLog(@"😄服务质量：%ld",op.qualityOfService);

    [op start];
}

/// NSInvocationOperation动态执行不同的selector
- (void)testOperation_invocation_changeSEL {
    NSArray *data = @[@"taskMethod2",@"taskMethod1001",@"taskMethod1002",@"taskMethod1003"];
    NSInvocationOperation * op=  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod1:) object:data];
    op.invocation.selector = NSSelectorFromString(data[0]); // 其中比较显著的一点就是我们可以根据上下文动态地调用 object 的不同 selector
    [op start];
}

/// 使用queue管理多个invocation任务
- (void)testOperation_invocation_queue {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    queue.maxConcurrentOperationCount = 1; // 自定义queue的maxConcurrentOperationCount默认值是-1，代表是并发队列
    NSInvocationOperation *op1 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(1)];
    NSInvocationOperation *op2 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(2)];
    NSInvocationOperation *op3 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(3)];
    NSInvocationOperation *op4 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(4)];
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
}

#pragma mark - override
- (NSString *)fileName {
    return @"thread_operation_invocation";
}


@end
