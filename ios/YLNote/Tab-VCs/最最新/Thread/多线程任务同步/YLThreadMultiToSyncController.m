//
//  YLThreadMultiToSyncController.m
//  YLNote
//
//  Created by tangh on 2023/1/29.
//  Copyright © 2023 tangh. All rights reserved.
//

#import "YLThreadMultiToSyncController.h"
// 实现A、B任务结束h后,执行C任务

@interface YLThreadMultiToSyncController ()

@end

@implementation YLThreadMultiToSyncController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)syncTask:(NSString *)name  {
    [[NSThread currentThread] setName:[NSString stringWithFormat:@"thread.pig.%@",name]];
    NSLog(@"🍊 %@: %@ Start,",name, NSStringFromSelector(_cmd));
    NSLog(@"main【33,%@】",[NSThread mainThread].name);
    NSLog(@"current【%ld,%@】",[NSThread currentThread].qualityOfService, [NSThread currentThread]);
    sleep(3);
    NSLog(@"🍊 %@: %@ Finish。",name, NSStringFromSelector(_cmd));
}

- (void)asyncTask:(NSString *)name queue:(dispatch_queue_t)queue complete:(void(^)(void)) finish {
    dispatch_async(queue, ^{
        [[NSThread currentThread] setName:[NSString stringWithFormat:@"thread.pig.%@",name]];
        NSLog(@"🍓 %@: %@ Start,",name, NSStringFromSelector(_cmd));
        NSLog(@"🍓 %@:【%ld,%@】",name ,[NSThread currentThread].qualityOfService, [NSThread currentThread]);
        NSLog(@"🍓 %@: %@ Finish。",name, NSStringFromSelector(_cmd));
        finish();
    });
    
}

#pragma mark - 异步任务同步
- (void)testMultiToSync_group_wait {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT,0);
    dispatch_group_enter(group);
    [self asyncTask:@"A" queue:queue complete:^{
        sleep(3);
        dispatch_group_leave(group);
    }];

    dispatch_group_enter(group);
    [self asyncTask:@"B" queue:queue complete:^{
        sleep(3);
        dispatch_group_leave(group);
    }];
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    dispatch_group_enter(group);
    [self asyncTask:@"C" queue:queue complete:^{
//        dispatch_group_leave(group);
    }];
}

- (void)testMultiToSync_group_notify {
    dispatch_queue_t queue = dispatch_queue_create("yuri.gcd.group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [self asyncTask:@"A" queue:queue complete:^{
        sleep(4);
        dispatch_group_leave(group);
    }];

    dispatch_group_enter(group);
    [self asyncTask:@"B" queue:queue complete:^{
        sleep(3);
        dispatch_group_leave(group);
    }];
    
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"-----C开始");
        [self asyncTask:@"C" queue:queue complete:^{
        }];
    });
}


#pragma mark - 线程依赖（实现C依赖B，B依赖A,即执行顺序：A->B->C）
- (void)testDependency_gcd_semaphore {
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT,0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [self asyncTask:@"A" queue:queue  complete:^{
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    [self asyncTask:@"B"  queue:queue complete:^{
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    [self asyncTask:@"C"  queue:queue complete:^{
    }];
}

- (void)testDependency_gcd_group {
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT,0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [self asyncTask:@"C" queue:queue  complete:^{
        dispatch_group_leave(group);
    }];

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_group_enter(group);
    [self asyncTask:@"B"  queue:queue complete:^{
        dispatch_group_leave(group);
    }];

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_group_enter(group);
    [self asyncTask:@"A"  queue:queue complete:^{
        dispatch_group_leave(group);
    }];
}

- (void)testDependency_setTarget {
    dispatch_queue_t queue_a = dispatch_queue_create("yuri.gcd.A", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue_b = dispatch_queue_create("yuri.gcd.B", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue = dispatch_queue_create("yuri.gccd.target", DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(queue_a, queue);
    dispatch_set_target_queue(queue_b, queue);
    dispatch_async(queue_a, ^{
        NSLog(@"A");
    });
    
    dispatch_async(queue_b, ^{
        NSLog(@"B");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"C");
    });
}

- (NSString *)fileName {
    return @"thread_multiToSync";
}

@end
