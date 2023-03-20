//
//  YLRunloopWithOtherViewController.m
//  YLNote
//
//  Created by tangh on 2021/9/2.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLRunloopWithOtherViewController.h"
#import "YLThread.h"
#import "YLNoteData.h"


static NSTimeInterval  validityInterval = 10;
@interface YLRunloopWithOtherViewController ()

@property (nonatomic,weak) NSTimer *myTimer;

@end

@implementation YLRunloopWithOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - task autoreleasepool
__weak id obj;
- (void)createAndConfigObserverInSecondaryThread {
    NSLog(@"🍎obj = test处设置断点使用watchpoint set variable obj命令观察obj，可以看到obj在释放时的方法调用栈");
    
    __autoreleasing id test = [NSObject new];
    NSLog(@"obj = %@", test);
    obj = test;
    [[NSThread currentThread] setName:@"Runloop.Thread.autoreleasepool"];
    NSLog(@"thread ending");
}
#pragma mark - task timer
- (void)doTaskCreatTimer {
    NSDate *originDate = [NSDate date];
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerTaskRepeat:) userInfo:originDate repeats:YES];
    self.myTimer = timer;
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:timer forMode:NSDefaultRunLoopMode];
    NSLog(@"🍎runloop start：%@",[NSThread currentThread].name);
    [runloop run];
    NSLog(@"🍎runloop end：%@",[NSThread currentThread].name);
    NSLog(@"注意：如果RunLoop不退出（运行中），这里的代码并不会执行，RunLoop本身就是一个循环.");
}

- (void)timerTaskRepeat:(NSTimer *)sender {
    NSDate *origin = sender.userInfo;
    if (origin && [origin isKindOfClass:[NSDate class]]) {
        // 超过设定时间退出runloop（限定时间：10秒）
        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:origin];
        NSLog(@"🍎时钟进度：[%f/%f, %@]",interval,validityInterval,[NSThread currentThread].name);
        if (interval > validityInterval) {
            [self.myTimer invalidate];
        }
    } else {
        [self.myTimer invalidate];
        NSLog(@"🍎获取起始时间失败，终止timer：%@",[NSThread currentThread].name);
    }
}

#pragma mark - task PerformSelector
- (void)doTaskPerform {
    NSLog(@"🍎runloop start：%@",[NSThread currentThread].name);// 断点查看runloop mode
    [self performSelector:@selector(printTaskThreadName)];
    // 非主线程RunLoop必须手动调用
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"🍎runloop end： %@",[NSThread currentThread].name);
    NSLog(@"注意：如果RunLoop不退出（运行中），这里的代码并不会执行，RunLoop本身就是一个循环.");

}

- (void)doTaskPerformDelay {
    NSLog(@"🍎runloop start：%@",[NSThread currentThread].name);// 断点查看runloop mode
    
    // 区分直接调用`doPerformDelayTask`和「performSelector:withObject:afterDelay:」区别,下面的直接调用无论是否运行RunLoop一样可以执行，但是后者则不行。
//     [self printTaskThreadName];
    [self performSelector:@selector(printTaskThreadName) withObject:nil afterDelay:8];
    
    // 取消当前RunLoop中注册测selector（注意：只是当前RunLoop，所以也只能在当前RunLoop中取消）
    // [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(doPerformDelayTask) object:nil];
//    NSLog(@"-：after performSelector:%@",[NSRunLoop currentRunLoop]); // 断点查看runloop mode
    
    // 非主线程RunLoop必须手动调用
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"🍎runloop end： %@",[NSThread currentThread].name);
    NSLog(@"注意：如果RunLoop不退出（运行中），这里的代码并不会执行，RunLoop本身就是一个循环.");

}

- (void)printTaskThreadName {
    NSLog(@"🍎进度：%@",[NSThread currentThread].name);

}

#pragma mark - actions
- (void)testAutoReleasepool {
    [NSThread detachNewThreadSelector:@selector(createAndConfigObserverInSecondaryThread) toTarget:self withObject:nil];
}

- (void)testUIRefresh {
    
}

- (void)testTimer {
    YLThread *thread = [[YLThread alloc] initWithTarget:self selector:@selector(doTaskCreatTimer) object:nil];
    thread.name = @"Runloop.Thread.timer";
    [thread start];
}

- (void)testPerformSelector {
    YLThread *thread = [[YLThread alloc] initWithTarget:self selector:@selector(doTaskPerform) object:nil];
    thread.name = @"Runloop.Thread.performSel";
    [thread start];

}

- (void)testPerformSelectorAfterdelay {
    YLThread *thread = [[YLThread alloc] initWithTarget:self selector:@selector(doTaskPerformDelay) object:nil];
    thread.name = @"Runloop.Thread.performSelAfterDelay";
    [thread start];

}

- (void)testNSPort {
    
}

- (void)testGCD {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSDate *originDate = [NSDate date];
    dispatch_async(queue, ^{
        [[NSThread currentThread] setName:@"Runloop.Thread.GCD"];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"🍎时钟进度：[%f/%f, %@]",[[NSDate date] timeIntervalSinceDate:originDate],validityInterval,[NSThread currentThread].name);
        }];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addTimer:timer forMode:NSRunLoopCommonModes];
        NSLog(@"🍎runloop start：%@",[NSThread currentThread].name);
        [runloop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:validityInterval]];
        NSLog(@"🍎runloop end：%@",[NSThread currentThread].name);
        NSLog(@"注意：如果RunLoop不退出（运行中），这里的代码并不会执行，RunLoop本身就是一个循环.");
    });
    
}
- (void)testNetWork {
    
    NSLog(@"");
}

#pragma mark - lazy
- (NSString *)fileName {
    return @"runloop_other";
}
@end
