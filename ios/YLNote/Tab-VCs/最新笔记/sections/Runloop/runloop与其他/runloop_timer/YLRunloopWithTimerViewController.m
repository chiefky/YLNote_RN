//
//  YLRunloopWithTimerViewController.m
//  YLNote
//
//  Created by tangh on 2022/2/10.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLRunloopWithTimerViewController.h"
#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>
#import "YLNote-Swift.h"
#import "YLThread.h"
#import "YLNoteData.h"

static NSString *cellIdentifier = @"kYLRunloopWithTimerViewControllerCell";

@interface YLRunloopWithTimerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *table;
@property (nonatomic,copy) NSArray<YLQuestion *> *datas;

/// 自动加入runloop的thread、timer实例
@property(nonatomic,strong) NSTimer *timer0;
@property(nonatomic,strong) NSThread *thread0;

/// 手动加入runloop的thread、timer实例
@property(nonatomic,strong) NSThread *thread1;
@property(nonatomic,strong) NSTimer *timer1;

/// 自动终止runloop的thread、timer实例
@property(nonatomic,strong) NSThread *thread2;
@property(nonatomic,strong) NSTimer *timer2;

/// 手动终止runloop的thread、timer实例
@property(nonatomic,strong) NSThread *thread3;
@property(nonatomic,strong) NSTimer *timer3;

@end

@implementation YLRunloopWithTimerViewController

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
#pragma mark - `scheduled` 或者 `perform:AfterDelay:` 方式向runloop添加timer
- (void)testScheduledTimer {
    self.thread0 = [[YLThread alloc] initWithTarget:self selector:@selector(scheduledTimerTask) object:nil];
    self.thread0.name = @"ylnode.runloop_with_timer.scheduledTimer";
    [self.thread0 start];
}

- (void)scheduledTimerTask {

    NSDate *begin = [NSDate date];
    NSDate *end = [NSDate dateWithTimeInterval:5 sinceDate:begin];
    __block NSInteger i = 1;
    //    第一个时间源
    self.timer0 = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"⏰ %ld：-------%@", i++,[NSThread currentThread].name);
    }];
    
    // 非主线程RunLoop必须手动run,且使用正确开启方式
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:end];

//    NSLog(@"runloop before performSelector:%@",[NSRunLoop currentRunLoop]);
    
    //    第二个时间源
    // 「performSelector:withObject:afterDelay:」执行’caculate‘要求 子线程的Runloop必须开启并运行。
//    [self performSelector:@selector(caculate) withObject:nil afterDelay:1];
    
    // 取消当前RunLoop中注册测selector（注意：只是当前RunLoop，所以也只能在当前RunLoop中取消）
//     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(caculate) object:nil];
    
    
    NSLog(@"注意：如果RunLoop不退出（运行中），这里的代码并不会执行，RunLoop本身就是一个循环.");
}

- (void)caculate {
    for (int i = 0;i < 9999;++i) {
        NSLog(@"%i,%@",i,[NSThread currentThread]);
        if ([NSThread currentThread].isCancelled) {
            return;
        }
    }
}

#pragma mark - `init` 或 `timerWithTimeInterval` 方式向runloop添加timer
- (void)testInitTimer {
    self.thread1 = [[YLThread alloc] initWithTarget:self selector:@selector(allocTimerWithTimeIntervalTask) object:nil];
    self.thread1.name = @"ylnode.runloop_with_timer.initWithTimeInterval";
    [self.thread1 start];
}

- (void)allocTimerWithTimeIntervalTask {
    NSDate *begin = [NSDate date];
    NSDate *end = [NSDate dateWithTimeInterval:5 sinceDate:begin];
    __block NSInteger i = 1;
     self.timer1 = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"⏰ %ld：-------%@", i++,[NSThread currentThread].name);
    }];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSRunLoopCommonModes];
    // 非主线程RunLoop必须手动调用(run in UITrackingMode下无法执行)
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:end];
    
    NSLog(@"注意：如果RunLoop不退出（运行中），这里的代码并不会执行，RunLoop本身就是一个循环.");
}

#pragma mark - 终止子线程timer 自动
- (void)testStopTimerAuto {
    __weak typeof(self) wkSelf = self;
    self.thread2 = [[YLThread alloc] initWithBlock:^{
        NSDate *begin = [NSDate date];
        NSDate *end = [NSDate dateWithTimeInterval:10 sinceDate:begin];
        __block NSInteger i = 1;
        //    第一个时间源
        wkSelf.timer2 = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"⏰ %ld：-------%@", i++,[NSThread currentThread].name);
        }];
        
        // 非主线程RunLoop必须手动run,且使用正确开启方式
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:end];

    }];
    self.thread2.name = @"ylnode.runloop_with_timer.stop_auto";
    [self.thread2 start];
}

#pragma mark - 终止子线程timer 手动
- (void)testStopTimerManual {
    __weak typeof(self) wkSelf = self;
    self.thread3 = [[YLThread alloc] initWithBlock:^{
        NSDate *begin = [NSDate date];
        NSDate *end = [NSDate dateWithTimeInterval:120 sinceDate:begin];
        __block NSInteger i = 1;
        //    第一个时间源
        wkSelf.timer3 = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"⏰ %ld：-------%@", i++,[NSThread currentThread].name);
        }];
        
        // 非主线程RunLoop必须手动run,且使用正确开启方式
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:end];

    }];
    self.thread3.name = @"ylnode.runloop_with_timer.stop_manual";
    [self.thread3 start];
}

- (void)testStopTimerManual_stop {
    [self performSelector:@selector(stopTimer3) onThread:self.thread3 withObject:nil waitUntilDone:NO];
}

- (void)stopTimer3 {
    [self.timer3 invalidate];
}

#pragma mark - UITableViewDelegate

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
            tmpCell.mySwitch.hidden = ![cellData.q_id isEqualToString:@"stop_manual"];
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
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YLQuestion *cellData = self.datas[indexPath.row];
    if (cellData && ![cellData.q_id isEqualToString:@"stop_manual"]) {
        NSString *funcName = cellData.function;
        SEL selector = NSSelectorFromString(funcName);
        if ([self respondsToSelector:selector]) {
            [self performSelector:selector];
        }
    };

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
        NSData *json = [YLFileManager jsonParseWithLocalFileName: @"runloop_timer"];
        _datas = [NSArray yy_modelArrayWithClass:[YLQuestion class] json:json];
    }
    
    return _datas;
}


@end
