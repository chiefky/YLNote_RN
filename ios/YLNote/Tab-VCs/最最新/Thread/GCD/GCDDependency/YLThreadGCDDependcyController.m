//
//  YLThreadGCDDependcyController.m
//  YLNote
//
//  Created by tangh on 2023/1/28.
//  Copyright © 2023 tangh. All rights reserved.
//

#import "YLThreadGCDDependcyController.h"
// 三个任务：A依赖B，B依赖C
@interface YLThreadGCDDependcyController ()

@end

@implementation YLThreadGCDDependcyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - funcs
- (void)task:(NSString *)order {
    NSLog(@"%@  start: -----------",order);
    NSLog(@"%@  熊宝宝飞奔而来",order);
    NSLog(@"%@  end: --------------",order);
}


// 串行队列+信号量
- (void)testGCD_dependency_serial_queue {
    dispatch_queue_t queue = dispatch_queue_create("gcd.dependency", DISPATCH_QUEUE_SERIAL);
    
    dispatch_semaphore_t seamphore = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        // CsendA
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0 ), ^{
            [self task:@"C"];
            NSLog(@"CCC Finish");
            dispatch_semaphore_signal(seamphore);
        });
    });
    dispatch_async(queue, ^{
        // wait'
        NSLog(@"BBB wait");
        dispatch_semaphore_wait(seamphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0 ), ^{
            [self task:@"B"];
            dispatch_semaphore_signal(seamphore);
        });
       
    });
    dispatch_async(queue, ^{
        // wait
        NSLog(@"AAA wait");
        dispatch_semaphore_wait(seamphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0 ), ^{
            [self task:@"A"];
        });
    });
    
}

/// 使用dispatch_group
- (void)testGCD_dependency_group1 {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        [self task:@"C"];
        dispatch_group_leave(group);
    });

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
         [self task:@"B"];
         dispatch_group_leave(group);
     });

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        [self task:@"A"];
        dispatch_group_leave(group);
    });

}

/// 使用dispatch_group
- (void)testGCD_dependency_group {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        [self task:@"C"];
        dispatch_group_leave(group);
    });

    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
         [self task:@"B"];
         dispatch_group_leave(group);
     });

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        [self task:@"A"];
        dispatch_group_leave(group);
    });

}


// 嵌套方式不推荐使用
//- (void)testGCD_dependency_group_notify {
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_queue_t group_queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0);
//    dispatch_group_async(group, group_queue, ^{
//        [self task:@"C"];
//    });
//
//    dispatch_group_notify(group, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
//        dispatch_group_async(group, group_queue, ^{
//            [self task:@"B"];
//        });
//
//        dispatch_group_notify(group, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
//            dispatch_group_async(group, group_queue, ^{
//                [self task:@"A"];
//            });
//        });
//    });
//
//
//}


- (void)taskMethod3:(NSNumber *) index {
    [[NSThread currentThread] setName:[NSString stringWithFormat:@"thread.pig.%@",index]];
    NSLog(@" 🍊 %@: %@ Start, main【33,%@】: , current【%ld,%@】",index, NSStringFromSelector(_cmd), [NSThread mainThread].name,[NSThread currentThread].qualityOfService, [NSThread currentThread]);
    sleep(3);
    NSLog(@" 🍊 %@: %@ Finish。",index, NSStringFromSelector(_cmd));
}


#pragma mark - override
- (NSString *)fileName {
    return @"thread-gcd_dependency";
}

@end
