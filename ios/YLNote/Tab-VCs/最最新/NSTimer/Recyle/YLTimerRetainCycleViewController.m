//
//  YLTimerRetainCycleViewController.m
//  YLNote
//
//  Created by tangh on 2021/7/31.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLTimerRetainCycleViewController.h"
#import "YLNote-Swift.h"
#import "YLProxy.h"
#import "YLTimer.h"
#import "YLNoteData.h"
#import "NSTimer+SafeBlock.h"

@interface YLTimerRetainCycleViewController ()

@property (nonatomic,strong) NSTimer *myTimer; //
@property (nonatomic,strong) YLTimer *ylTimer; //自定义timer
@property (nonatomic,strong) NSTimer *mySchdueTimer; // iOS10以上API
@property (nonatomic,strong) NSTimer *myBlockTimer; // safe timer: + block
@property (nonatomic,strong) NSTimer *myProxyTimer; // proxy

@end

@implementation YLTimerRetainCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)dealloc {
    [self ylTimer_invalidate];
    [self mySchdueTimer_invalidate];
    [self myBlockTimer_invalidate];
    [self myProxyTimer_invalidate];
    NSLog(@"%s",__FUNCTION__);
}


#pragma mark - 创建timer
- (void)testCreateTimer {

    // 第一种：
    self.myTimer = [NSTimer timerWithTimeInterval:1
                                         target:self
                                         selector:@selector(printLog:)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.myTimer
                                      forMode:NSRunLoopCommonModes];

//    // 第二种：
//    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1
//                                                  target:self
//                                                  selector:@selector(printLog:)
//                                                userInfo:nil
//                                                 repeats:YES];
//
//    // 第三种：iOS10以上使用，将target的循环引用变更为block的循环引用,使用时注意打破block的循环引用
//    __weak typeof(self) weakSelf = self;
//    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf printLog:nil];
//    }];

}
- (void)printLog:(id)sender {
    NSLog(@"%p:Hello , %@",sender,[NSDate date]);
}

/// presentViewController不会调用viewWillDisAppear函数，所以在viewWillDisAppear方法中释放timer不合适
- (void)testPushNextPage_timer {
    YLSwiftViewController *vc = [[YLSwiftViewController alloc] init];
    
    [self presentViewController:vc animated:YES completion:^{
        NSLog(@"presentViewController over");
    }];
}

#pragma mark - 解决Timer循环引用的四种方案
/// 方案一：自定义timer
- (void)testResolveTimerRecycle_custom {
    self.ylTimer = [[YLTimer alloc] init];
    [self.ylTimer startTimerWithInterval:3];
}
- (void)ylTimer_invalidate {
    if (!self.ylTimer) {
        return;
    }
    [self.ylTimer stopTimer];
}
/// 方案二：使用iOS10新增接口初始化timer
- (void)testResolveTimerRecycle_latest_api {
    __weak typeof(self) weakSelf = self;
    self.mySchdueTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf printLog:nil];
    }];
}

- (void)mySchdueTimer_invalidate {
    if (!self.mySchdueTimer) {
        return;
    }
    [self.mySchdueTimer invalidate];
    self.mySchdueTimer = nil;
}

/// 方案三：借助block
- (void)testResolveTimerRecycle_block {
    __weak typeof(self) weakSelf = self;
    self.myBlockTimer = [NSTimer yl_ScheduledTimerWithTimeInterval:2 repeats:YES block:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf printLog:nil];
    } ];
}

- (void)myBlockTimer_invalidate {
    if (!self.myBlockTimer) {
        return;
    }
    [self.myBlockTimer invalidate];
    self.myBlockTimer = nil;
}

/// 方案四：借助proxy
///使用NSProxy（其实是借助参数传递中间者+中间者弱持有self就可以解决，完全可以不用消息转发）（使用Proxy的原理是：1.添加了一个中间者Proxy；2.Proxy持有一个弱引用对象，也就是响应方法的目标对象；3. 借助消息转发机制将消息传递给目标对象）

- (void)testResolveTimerRecycle_proxy {
    YLProxy *proxy = [[YLProxy alloc] initWithTarget:self];
    self.myProxyTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:proxy selector:@selector(printLog:) userInfo:nil repeats:YES];
}

- (void)myProxyTimer_invalidate {
    if (!self.myProxyTimer) {
        return;
    }
    [self.myProxyTimer invalidate];
    self.myProxyTimer = nil;
}

#pragma mark -lazy 数据源
- (NSString *)fileName {
    return @"timer_recycle";
}

@end
