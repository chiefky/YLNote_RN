//
//  YLRunloopKeepThreadAliveVController.m
//  YLNote
//
//  Created by tangh on 2021/9/7.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLRunloopKeepThreadAliveVController.h"
#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>
#import "YLNote-Swift.h"
#import "YLThread.h"
#import "YLNoteData.h"

@interface YLRunloopKeepThreadAliveVController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) NSThread *myThread;
@property (nonatomic,strong)UITableView *table;

@property (nonatomic,copy) NSArray<YLQuestion *> *datas;
@property (nonatomic, strong) NSTimer *myTimer;


@end

@implementation YLRunloopKeepThreadAliveVController

static NSString *cellIdentifier = @"YLNoteSwitchTableViewCell";

- (void)dealloc {
    NSLog(@"%@,%s",[self class],__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"YLNoteSwitchTableViewCell" ofType:@"nib"];
    if (path) {
        [self.table registerNib:[UINib nibWithNibName:@"YLNoteSwitchTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    } else {
        [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    }    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[YLNoteSwitchTableViewCell class]]) {
        YLNoteSwitchTableViewCell *tmpCell = (YLNoteSwitchTableViewCell *)cell;
        YLQuestion *cellData = self.datas[indexPath.row];
        __weak typeof(self) wkSelf = self;
        if (cellData) {
            tmpCell.titleLabel.text = cellData.title;
            if (cellData.showArticle) {
                [tmpCell.articleButton setImage:[UIImage imageNamed: @"article"] forState:UIControlStateNormal];
                tmpCell.articleHandler = ^{
                    if (cellData.showArticle) {
                        [UIWindow pushToArticleVC:cellData];
                    }
                };
            }
            tmpCell.switchHandler = ^(BOOL open) {
                NSString *funcName = open ? cellData.function : [cellData.function stringByAppendingString:@"_stop"];
                SEL selector = NSSelectorFromString(funcName);
                if ([wkSelf respondsToSelector:selector]) {
                    [wkSelf performSelector:selector];
                }
            };
        };
        
    };
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    YLQuestion *cellData = self.datas[indexPath.row];
//    if (cellData) {
//        NSString *funcName = cellData.funcName;
//        SEL selector = NSSelectorFromString(funcName);
//        if ([self respondsToSelector:selector]) {
//            [self performSelector:selector];
//        }
//    }
//}

#pragma mark - 手动终止runloop
- (void)stopLoop {
    CFRunLoopRef cf = [NSRunLoop currentRunLoop].getCFRunLoop;
    NSLog(@"-：CFRunLoopStop()终止当前线程的runloop");
    CFRunLoopStop(cf);
}

#pragma mark - 自定义source
/// 手动终止source0 任务
- (void)testSource0_stop {
    [self performSelector:@selector(stopLoop) onThread:self.myThread withObject:nil waitUntilDone:YES];
}

/// 开启source0 任务
- (void)testSource0 {
    YLThread *thread = [[YLThread alloc] initWithTarget:self selector:@selector(taskSource0) object:nil];
    self.myThread = thread;
    thread.name = @"YLThread.source0";
    [thread start];
}

/// soucre0任务
- (void)taskSource0 {
    CFRunLoopSourceContext  context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL,NULL,NULL,RunLoopSourcePerformRoutine};
    // 创建&添加事件源source0
    CFRunLoopSourceRef source0 = CFRunLoopSourceCreate(NULL, 0, &context);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source0, kCFRunLoopDefaultMode);
    NSLog(@"🍑 runloop start：%@",[NSThread currentThread].name);
    // 将source0任务标记为待处理事件
    CFRunLoopSourceSignal(source0);
    CFRunLoopRun();
    NSLog(@"🍑 runloop finished：%@",[NSThread currentThread].name);
}


- (void)taskSource0WithObserver {
    NSThread *currentThread = [NSThread currentThread];
    NSLog(@"%@ thread start...",currentThread.name);
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    CFRunLoopRef cfLoop = CFRunLoopGetCurrent();
    
    // 设置Run Loop observer的运行环境
    CFRunLoopObserverContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    
    // 创建Run loop observer对象
    // 第一个参数用于分配该observer对象的内存
    // 第二个参数用以设置该observer所要关注的的事件，详见回调函数myRunLoopObserver中注释
    // 第三个参数用于标识该observer是在第一次进入run loop时执行还是每次进入run loop处理时均执行
    // 第四个参数用于设置该observer的优先级
    // 第五个参数用于设置该observer的回调函数
    // 第六个参数用于设置该observer的运行环境
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,kCFRunLoopAllActivities, YES, 0, &YLRunLoopObserverHandler, &context);
    if (observer){
        CFRunLoopAddObserver(cfLoop, observer, kCFRunLoopDefaultMode);
    }
    
    CFRunLoopSourceContext  source0Context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL,
        &RunLoopSourceScheduleRoutine,
        RunLoopSourceCancelRoutine,
        RunLoopSourcePerformRoutine};
    
    // 添加事件源
    CFRunLoopSourceRef source0 = CFRunLoopSourceCreate(NULL, 0, &source0Context);
    CFRunLoopAddSource(cfLoop, source0, kCFRunLoopDefaultMode);
    
    while (!self.myThread.isCancelled) {
        // 将source0任务标记为待处理事件
        CFRunLoopSourceSignal(source0);
        [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:5.0f]]; // 5秒后runloop stop
    }
    
    // 移除source源 ，结束Runloop
    CFRunLoopRemoveSource(cfLoop, source0, kCFRunLoopDefaultMode);
    
}

#pragma mark- mach port （Foundation 下只能通过port自动完成source1的创建和配置；CoreFoundation下则需要手动创建port和source1
- (void)testMachPort {
    YLThread *thread = [[YLThread alloc] initWithTarget:self selector:@selector(taskPort) object:nil];
    self.myThread = thread;
    thread.name = @"YLThread.mach_port";
    [thread start];
}

/// 外部手动终止子线程runloop
- (void)testMachPort_stop {
    [self performSelector:@selector(stopLoop) onThread:self.myThread withObject:nil waitUntilDone:YES];
}

/// 子线程任务（备注：❌：代表无法手动终止runloop（原因是：会无限执行一个无事件源的runMode方法）； ✅：代表可以手动终止runloop）
- (void)taskPort {
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    NSLog(@"🍎 runloop start：%@",[NSThread currentThread].name);
    NSLog(@"do things what you want");
    // 方式1：使用Foundation接口开启runloop
    //            [runLoop run]; // run: ❌
    //            [runLoop runUntilDate:[NSDate distantFuture]]; // runUntilDate: ❌
    [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]; // runMode: ✅
    
    // 方式2：使用Core Foundation接口开启runloop
    //            CFRunLoopRun(); // CFRunLoopRun: ✅
    //            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1000000, YES); // CFRunLoopRunInMode: ✅
    NSLog(@"🍎 finished： %@",[NSThread currentThread].name);
}

#pragma mark - timer
- (void)timerInvalid {
    [self.myTimer invalidate];
    NSLog(@"🍊 runloop end：%@,%@",[NSThread currentThread].name,[NSRunLoop currentRunLoop]);// 断点查看runloop mode
}

- (void)testTimer_stop {
    [self.myThread cancel];
}

- (void)testTimer {
    YLThread *thread = [[YLThread alloc] initWithTarget:self selector:@selector(taskTimer) object:nil];
    self.myThread = thread;
    thread.name = @"YLThread.timer";
    [thread start];
}

- (void)taskTimer {
    // 使用下面的方式创建定时器虽然会自动加入到当前线程的RunLoop中，但是除了主线程外其他线程的RunLoop默认是不会运行的，必须手动调用
    __weak typeof(self) weakSelf = self;
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if ([NSThread currentThread].isCancelled) {
            // [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:@selector(doPerformDelayTask) object:nil];
            // [NSThread exit];
            [weakSelf.myTimer invalidate];
        }
        NSLog(@"timer1...");
    }];
    NSLog(@"🍊 runloop start：%@,%@",[NSThread currentThread].name,[NSRunLoop currentRunLoop]);// 断点查看runloop mode
    
    // 区分直接调用`doPerformDelayTask`和「performSelector:withObject:afterDelay:」区别,下面的直接调用无论是否运行RunLoop一样可以执行，但是后者则不行。
    // [self doPerformDelayTask];
//    [self performSelector:@selector(doPerformDelayTask) withObject:nil afterDelay:2.0];
    
    // 取消当前RunLoop中注册测selector（注意：只是当前RunLoop，所以也只能在当前RunLoop中取消）
    // [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(doPerformDelayTask) object:nil];
//    NSLog(@"-：after performSelector:%@",[NSRunLoop currentRunLoop]); // 断点查看runloop mode
    
    // 非主线程RunLoop必须手动调用
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"🍊 finished： %@",[NSThread currentThread].name);
    NSLog(@"注意：如果RunLoop不退出（运行中），这里的代码并不会执行，RunLoop本身就是一个循环.");
}


- (void)doPerformDelayTask {
    NSLog(@"%@: 延迟2秒打印当前线程",[NSThread currentThread]);
}

#pragma mark - observerHandler

void YLRunLoopObserverHandler(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    switch(activity)
    {
            // 即将进入Loop
        case kCFRunLoopEntry:
            NSLog(@"run loop entry");
            break;
        case kCFRunLoopBeforeTimers://即将处理 Timer
            NSLog(@"run loop before timers");
            break;
        case kCFRunLoopBeforeSources://即将处理 Source
            NSLog(@"run loop before sources");
            break;
        case kCFRunLoopBeforeWaiting://即将进入休眠
            NSLog(@"run loop before waiting");
            break;
        case kCFRunLoopAfterWaiting://刚从休眠中唤醒
            NSLog(@"run loop after waiting");
            break;
        case kCFRunLoopExit://即将退出Loop
            NSLog(@"run loop exit");
            break;
        default:
            break;
    }
}

#pragma mark - Source Handler
/**
 *  调度例程
 *  当将输入源安装到run loop后，调用这个协调调度例程，将源注册到客户端（可以理解为其他线程）
 *
 */
void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    NSLog(@"-：RunLoopSourceScheduleRoutine");
}

/**
 *  处理例程
 *  在输入源被告知（signal source）时，调用这个处理例程
 *
 */
void RunLoopSourcePerformRoutine (void *info)
{
    NSLog(@"-：source0被标记事务执行%s",__FUNCTION__);
}

/**
 *  取消例程
 *  如果使用CFRunLoopSourceInvalidate/CFRunLoopRemoveSource函数把输入源从run loop里面移除的话，系统会调用这个取消例程，并且把输入源从注册的客户端（可以理解为其他线程）里面移除
 *
 */
void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    NSLog(@"-：RunLoopSourceCancelRoutine");
}

#pragma mark - lazys
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.rowHeight = 50;
        
    }
    return _table;
}

- (NSArray<YLQuestion *> *)datas {
    if (!_datas) {
        _datas = [NSArray array];
        NSData *json = [YLFileManager jsonParseWithLocalFileName: @"runloop_alive"];
        _datas = [NSArray yy_modelArrayWithClass:[YLQuestion class] json:json];
    }
    
    return _datas;
}

@end
