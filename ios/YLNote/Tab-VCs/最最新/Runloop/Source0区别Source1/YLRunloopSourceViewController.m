//
//  YLRunloopSourceViewController.m
//  YLNote
//
//  Created by tangh on 2021/9/2.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLRunloopSourceViewController.h"
#import "YLThread.h"
#import "YLNoteData.h"

@interface YLRunloopSourceViewController ()

@property(nonatomic,strong) YLThread *sourceThread;

@end

@implementation YLRunloopSourceViewController
- (void)dealloc {
    NSLog(@"hhhhhh: %s",__FUNCTION__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)testSource0 {
     YLThread *thread0 = [[YLThread alloc] initWithBlock:^{
         NSLog(@"source0 test~~~");
        CFRunLoopSourceContext context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL, NULL, NULL, runLoopSourcePerformRoutine};

        CFRunLoopSourceRef rls = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
        CFRunLoopAddSource(CFRunLoopGetCurrent(), rls, kCFRunLoopDefaultMode);

        // 创建好的 rls 必须手动标记为待处理，否则即使 run loop 正常循环也不会执行此 rls
        CFRunLoopSourceSignal(rls); // ⬅️ 断点 1

//         由于计时器一直在循环执行，所以这里可不需要我们手动唤醒 run loop
        CFRunLoopWakeUp(CFRunLoopGetCurrent()); // ⬅️ 断点 2
         
//          添加一个时间源，目的是合理时机移除掉source0
         __block NSInteger i = 1;
        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {

            // 每次执行source0任务时都需要标记为待处理事件
            CFRunLoopSourceSignal(rls);
            // 由于计时器一直在循环执行，所以这里可不需要我们手动唤醒 run loop
            // CFRunLoopWakeUp(CFRunLoopGetCurrent());

            if (i > 10) {
                // 为防止runloop启动后线程一直保活造成内存泄漏，需要移除所有mode item 或者 手动终止runloop；Thread才能够被销毁

                CFRunLoopRemoveSource(CFRunLoopGetCurrent(), rls, kCFRunLoopDefaultMode); // 移除source0
                [timer invalidate]; // timer终止时，会自动从runloop中移除
                // CFRunLoopStop(CFRunLoopGetCurrent());
            }
            NSLog(@"timer： %ld次回调...",i++);

        }];
         CFRunLoopRun();
    }];

    [thread0 setName:@"🍎"];
    [thread0 start];
}

void runLoopSourcePerformRoutine (void *info) {
    NSLog(@"source0： 线程%@，Hello world!", [NSThread currentThread].name); // ⬅️ 断点 3
}


- (void)testSource1 {
    self.sourceThread = [[YLThread alloc] initWithBlock:^{

    }];
    [self.sourceThread setName: @"🍑"];
    [self.sourceThread start];
    NSLog(@"source0： 线程%@，Hello world!", [NSThread currentThread].name); //
}

#pragma mark - source 的区别
- (NSString *)fileName {
    return @"runloop_source";
}

@end
