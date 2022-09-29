//
//  YLRunloopWithPerfomSELViewController.m
//  YLNote
//
//  Created by tangh on 2022/2/11.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLRunloopWithPerfomSELViewController.h"
#import "YLThread.h"
@interface YLRunloopWithPerfomSELViewController ()

@end

@implementation YLRunloopWithPerfomSELViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self performSelector:@selector(makeAndModel)];
    // Do any additional setup after loading the view.
}


- (void)printInfo {
    NSLog(@"SEL : %s",__func__);
}

#pragma mark - functions
/// "❌NSThread创建线程：先run,后performSelectoe:afterDelay:"
- (void)testPerformSelAfterDelayOnNSthreadWrong {
    YLThread *mythread = [[YLThread alloc] initWithBlock:^{
        [[NSRunLoop currentRunLoop] run]; // 此时runloop中没有事件源，事件源无法开启成功，所以printInfo不会执行
        [self performSelector:@selector(printInfo) withObject:nil afterDelay:1];
    }];
    [mythread start];
    NSLog(@"%s: Hello world",__func__);
}

/// "✅NSThread创建线程：先performSelectoe:afterDelay:，后run"
- (void)testPerformSelAfterDelayOnNSthreadRight {
    YLThread *mythread = [[YLThread alloc] initWithBlock:^{
        [self performSelector:@selector(printInfo) withObject:nil afterDelay:1];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

    }];
    [mythread start];
    NSLog(@"%s: Hello world",__func__);
}
/// "✅GCD子线程：经验证，同NSThread一致"
- (void)testPerformSelAfterDelayOnGCDRight {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        [self performSelector:@selector(printInfo) withObject:nil afterDelay:1];
        NSLog(@"---: block end");
    });
    NSLog(@"%s: Hello world",__func__);
}

/// "❌NSThread子线程：不执行"原因： 子线程执行完操作之后就会立即释放，即使我们使用强引用引用子线程使子线程不被释放，也不能给子线程再次添加操作，或者再次开启。这里可以使用Runloop。子线程获取其对应的Runloop对象并使之运行。一般使用常驻子线程。
- (void)testPerformSelOnNSthreadUntilDateWrong {
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"---: block end");
    }];
    [thread start];
    [self performSelector:@selector(printInfo) onThread:thread withObject:nil waitUntilDone:NO];
}

/// "✅NSThread子线程：仅执行一次"
- (void)testPerformSelOnNSthreadUntilDateRight {
    YLThread *thread = [[YLThread alloc] initWithBlock:^{
       // 执行一次而已
       [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }];
    [thread start];
    [self performSelector:@selector(printInfo) onThread:thread withObject:nil waitUntilDone:NO];
}

#pragma mark - overide
- (NSString *)fileName {
    return @"runloop_performSEL";
}

@end
