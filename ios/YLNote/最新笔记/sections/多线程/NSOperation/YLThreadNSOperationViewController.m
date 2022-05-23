//
//  YLThreadNSOperationViewController.m
//  YLNote
//
//  Created by tangh on 2022/2/20.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLThreadNSOperationViewController.h"

@interface YLThreadNSOperationViewController ()
@end

@implementation YLThreadNSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - funcs

- (void)taskMethod3:(NSNumber *) index {
    [[NSThread currentThread] setName:[NSString stringWithFormat:@"thread.pig.%@",index]];
    NSLog(@" 🍊 %@: %@ Start, main【33,%@】: , current【%ld,%@】",index, NSStringFromSelector(_cmd), [NSThread mainThread].name,[NSThread currentThread].qualityOfService, [NSThread currentThread]);
    sleep(3);
    NSLog(@" 🍊 %@: %@ Finish。",index, NSStringFromSelector(_cmd));
}


/// 添加多任务依赖关系(使用queue)
- (void)testOperation_invocation_dependency_queue {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *op1 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(1)];
    NSInvocationOperation *op2 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(2)];
    NSInvocationOperation *op3 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(3)];
    NSInvocationOperation *op4 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(4)];

    [op1 addDependency:op2];
    [op2 addDependency:op3];
    [op3 addDependency:op4];

    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];

}

/// 添加多任务依赖关系(不使用queue)
- (void)testOperation_invocation_dependency_non_queue {
    NSInvocationOperation *op1 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(1)];
    NSInvocationOperation *op2 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(2)];
    NSInvocationOperation *op3 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(3)];
    NSInvocationOperation *op4 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(4)];
// 依赖顺序是： op1->op2->op3->op4；
// start顺序必须是：op4,op3,op2,op1; （因为不使用queue,单独使用Operation都是同步任务，在有依赖的情况下必须等上一个任务执行完才能开启当前任务）
    [op1 addDependency:op2];
    [op2 addDependency:op3];
    [op3 addDependency:op4];
    
    [op4 start];
    [op3 start];
    [op2 start];
    [op1 start];
}
/// 修改 Operation 在队列中的优先级,第二优先级【queuePriority】
- (void)testOperation_invocation_queuePriority {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    for (NSInteger i = 1; i <= 4; i++) {
        NSInvocationOperation *op =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(i)];
        op.queuePriority = (i == 3) ? NSOperationQueuePriorityVeryLow : NSOperationQueuePriorityVeryHigh;
        [queue addOperation:op];
    }

}

/// 修改 Operation 执行任务线程的优先级
- (void)testOperation_invocation_qualityOfService {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    queue.qualityOfService = NSQualityOfServiceUserInteractive;
    NSInvocationOperation *op1 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(1)];
    NSInvocationOperation *op2 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(2)];
    NSInvocationOperation *op3 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(3)];
    NSInvocationOperation *op4 =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod3:) object:@(4)];
    op1.qualityOfService = NSQualityOfServiceUserInitiated;
    op2.qualityOfService = NSQualityOfServiceBackground;

    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    
    for (NSOperation *op in queue.operations) {
        NSLog(@"优先级：%ld",(long)op.qualityOfService);
    }
    NSLog(@"queue 的优先级：%ld",(long)queue.qualityOfService);

}

#pragma mark - override
- (NSString *)fileName {
    return @"thread_nsoperation";
}


@end
