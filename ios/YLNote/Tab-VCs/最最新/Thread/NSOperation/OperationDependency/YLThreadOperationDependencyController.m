//
//  YLThreadOperationDependencyController.m
//  YLNote
//
//  Created by tangh on 2023/1/28.
//  Copyright © 2023 tangh. All rights reserved.
//

#import "YLThreadOperationDependencyController.h"

@interface YLThreadOperationDependencyController ()

@end

@implementation YLThreadOperationDependencyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - funcs

- (void)task:(NSString *) index {
    [[NSThread currentThread] setName:[NSString stringWithFormat:@"thread.pig.%@",index]];
    NSLog(@" 🍊 %@: %@ Start, main【33,%@】: , current【%ld,%@】",index, NSStringFromSelector(_cmd), [NSThread mainThread].name,[NSThread currentThread].qualityOfService, [NSThread currentThread]);
    sleep(3);
    NSLog(@" 🍊 %@: %@ Finish。",index, NSStringFromSelector(_cmd));
}


- (void)taskWithOperation:(NSString *) name {
    [[NSThread currentThread] setName:[NSString stringWithFormat:@"thread.pig.%@",name]];
    NSLog(@"🍓 %@: %@ Start, main【33,%@】: , current【%ld,%@】",name, NSStringFromSelector(_cmd), [NSThread mainThread].name,[NSThread currentThread].qualityOfService, [NSThread currentThread]);
    sleep(3);
    NSLog(@"🍓 %@: %@ Finish。",name, NSStringFromSelector(_cmd));
}

/// queue + addDependency
/// 使用queue添加多任务依赖关系
/// 注意：addDependency 必须在addOperation之前
- (void)testOperation_invocation_dependency_queue {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *op_a =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"A"];
    NSInvocationOperation *op_b =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"B"];
    NSInvocationOperation *op_c =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"C"];
    NSInvocationOperation *op_d =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"D"];

    [op_a addDependency:op_b];
    [op_b addDependency:op_c];
    [op_c addDependency:op_d];

    [queue addOperation:op_a];
    [queue addOperation:op_b];
    [queue addOperation:op_c];
    [queue addOperation:op_d];

}

/// 只使用addDependency，不使用queue
/// 使用queue添加多任务依赖关系
/// 注意： start顺序必须是：op_d,op_c,op_b,op_a; （因为不使用queue,单独使用Operation都是同步任务，在有依赖的情况下必须等上一个任务执行完才能开启当前任务）

- (void)testOperation_invocation_dependency_non_queue {
    NSInvocationOperation *op_a =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"A"];
    NSInvocationOperation *op_b =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"B"];
    NSInvocationOperation *op_c =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"C"];
    NSInvocationOperation *op_d =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"D"];
// 依赖顺序是： op_a->op_b->op_c->op_d；
// start顺序必须是：op_d,op_c,op_b,op_a; （因为不使用queue,单独使用Operation都是同步任务，在有依赖的情况下必须等上一个任务执行完才能开启当前任务）
    [op_a addDependency:op_b];
    [op_b addDependency:op_c];
    [op_c addDependency:op_d];
    
    [op_d start];
    [op_c start];
    [op_b start];
    [op_a start];
}

///  queue + queuePriority
/// 修改 Operation 在队列中的优先级,第二优先级【queuePriority】
- (void)testOperation_invocation_queuePriority {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    queue.qualityOfService = NSQualityOfServiceUserInteractive;
    NSInvocationOperation *op_a =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"A"];
    op_a.name = @"A";
    op_a.queuePriority = NSOperationQueuePriorityVeryLow;
   
    NSInvocationOperation *op_b = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"B"];
    op_b.name = @"B";
    op_b.queuePriority = NSOperationQueuePriorityLow;

    NSInvocationOperation *op_c =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"C"];
    op_c.name = @"C";
    op_c.queuePriority = NSOperationQueuePriorityNormal;

    NSInvocationOperation *op_d =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"D"];
    op_d.name = @"D";
    op_d.queuePriority = NSOperationQueuePriorityVeryHigh;

    [queue addOperation:op_a];
    [queue addOperation:op_b];
    [queue addOperation:op_c];
    [queue addOperation:op_d];

    for (NSOperation *op in queue.operations) {
        NSLog(@"%@ 优先级(queuePriority)：%ld",op.name,(long)op.queuePriority);
    }
    NSLog(@"queue 的优先级(qos)：%ld",(long)queue.qualityOfService);

}

/// 修改 Operation 执行任务线程的优先级
- (void)testOperation_invocation_qualityOfService {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    queue.qualityOfService = NSQualityOfServiceUserInteractive;
    NSInvocationOperation *op_a =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskWithOperation:) object:@"A"];
    op_a.name = @"A";
    NSInvocationOperation *op_b = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskWithOperation:) object:@"B"];
    op_b.name = @"B";
    NSInvocationOperation *op_c =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskWithOperation:) object:@"C"];
    op_c.name = @"C";

    NSInvocationOperation *op_d =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskWithOperation:) object:@"D"];
    op_d.name = @"D";
    
    op_d.qualityOfService = NSQualityOfServiceUserInitiated ;// 25
    op_c.qualityOfService = NSQualityOfServiceDefault;// -1
    op_b.qualityOfService = NSQualityOfServiceUtility;// 17
    op_a.qualityOfService = NSQualityOfServiceBackground; // 9

    [queue addOperation:op_a];
    [queue addOperation:op_b];
    [queue addOperation:op_c];
    [queue addOperation:op_d];
    
//    for (NSOperation *op in queue.operations) {
//        NSLog(@"%@ 优先级(qos)：%ld",op.name,(long)op.qualityOfService);
//    }
//    NSLog(@"queue 的优先级(qos)：%ld",(long)queue.qualityOfService);

}


#pragma mark - override
- (NSString *)fileName {
    return @"thread-nsoperation_dependency";
}
@end
