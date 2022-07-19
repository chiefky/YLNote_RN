//
//  YLRunloopRunViewController.m
//  YLNote
//
//  Created by tangh on 2021/9/2.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLRunloopRunViewController.h"
#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>
#import "YLNote-Swift.h"
#import "YLThread.h"
#import "YLNoteData.h"

static NSString *cellIdentifier = @"YLRunloopRunViewControllerCell";

@interface YLRunloopRunViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *table;
@property (nonatomic,copy) NSArray<YLQuestion *> *datas;

@property (nonatomic,strong)NSTimer *myTimer;
@property (nonatomic,strong)YLThread *thread1; // runloop run
@property (nonatomic,strong)YLThread *thread2; // runloop runUntilDate
@property (nonatomic,strong)YLThread *thread3; // runloop runMode
@property (nonatomic,strong)YLThread *thread4; // runloop timer手动终止
@property (nonatomic,strong)YLThread *thread5; // runloop source手动终止

@end

CFRunLoopRef runloop;
@implementation YLRunloopRunViewController
#pragma mark - lifecycle
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

#pragma mark - test code
- (void)stopLoop {
    CFRunLoopRef cf = [NSRunLoop currentRunLoop].getCFRunLoop;
    NSLog(@"-：CFRunLoopStop()终止当前线程的runloop");
    CFRunLoopStop(cf);
}

- (void)stopTimer {
    [self.myTimer invalidate];
    self.myTimer = nil;
}

#pragma mark - run/stop
/**
 YLThread:"ylnode.runloop.run",如果不设置超时时间，runloop永远不会终止，即使调用
 */
- (void)testMemory_run {
    __weak typeof(self) wkSelf = self;
    self.thread1 = [[YLThread alloc] initWithBlock:^{
        __block NSInteger i = 1;
        NSDate *begin = [NSDate date];
        wkSelf.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:begin];
            NSLog(@"⏰ %ld-%f：-------%@", i++,interval,[NSThread currentThread].name);
            
        }];
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"runloop 终止了？？？-- NO,这一行并不执行");
    }];
    self.thread1.name = @"ylnode.runloop.run";
    [self.thread1 start];

}

- (void)testMemory_run_stop {
    [self performSelector:@selector(stopTimer) onThread:self.thread1 withObject:nil waitUntilDone:YES];
}

#pragma mark - runUntilDate/stop
- (void)testMemory_runUntilDate {
    __weak typeof(self) wkSelf = self;
    self.thread2 = [[YLThread alloc] initWithBlock:^{
        NSDate *begin = [NSDate date];
        NSDate *end = [NSDate dateWithTimeInterval:30 sinceDate:begin];
        __block NSInteger i = 1;
        wkSelf.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"⏰ %ld：-------%@", i++,[NSThread currentThread].name);
        }];
        [[NSRunLoop currentRunLoop] runUntilDate:end];
    }];
    self.thread2.name = @"ylnode.runloop.runUntilDate";
    [self.thread2 start];
}

- (void)testMemory_runUntilDate_stop {
    [self performSelector:@selector(stopTimer) onThread:self.thread2 withObject:nil waitUntilDone:YES];
}

#pragma mark - runMode/stop
- (void)testMemory_runMode {
    __weak typeof(self) weakSelf = self;
    self.thread3 = [[YLThread alloc] initWithBlock:^{
        NSDate *begin = [NSDate date];
        NSDate *end = [NSDate dateWithTimeInterval:50 sinceDate:begin];
        __block NSInteger i = 1;
        weakSelf.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"⏰ %ld：-------%@", i++,[NSThread currentThread].name);
        }];
        
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:end];
    }];
    self.thread3.name = @"ylnode.runloop.runMode";
    [self.thread3 start];
}

- (void)testMemory_runMode_stop {
    NSLog(@"runloop中的timer只能通过invalid使其终止，无法使用CFRunloopStop()函数终止");
    [self performSelector:@selector(stopTimer) onThread:self.thread3 withObject:nil waitUntilDone:YES];
}
#pragma mark - 手动终止runloop,timer
- (void)testRunloop_timer {
    __weak typeof(self) weakSelf = self;
    self.thread4 = [[YLThread alloc] initWithBlock:^{
        NSDate *begin = [NSDate date];
        NSDate *end = [NSDate dateWithTimeInterval:50 sinceDate:begin];
        __block NSInteger i = 1;
        weakSelf.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"⏰ %ld：-------%@", i++,[NSThread currentThread].name);
        }];
        
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:end];
    }];
    self.thread4.name = @"ylnode.runloop.manualStop.timer";
    [self.thread4 start];
}

- (void)testRunloop_timer_stop {
    [self performSelector:@selector(stopTimer) onThread:self.thread4 withObject:nil waitUntilDone:YES];
}

#pragma mark - 手动终止runloop,source1: NSPort
- (void)testRunloop_source {
    self.thread5 = [[YLThread alloc] initWithBlock:^{
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        NSLog(@"💻 runloop start：%@",[NSThread currentThread].name);
        NSLog(@"do things what you want");
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }];
    self.thread5.name = @"ylnode.runloop.manualStop.source1";
    [self.thread5 start];
}

- (void)testRunloop_source_stop {
    [self performSelector:@selector(stopLoop) onThread:self.thread5 withObject:nil waitUntilDone:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

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
        NSData *json = [YLFileManager jsonParseWithLocalFileName: @"runloop_run"];
        _datas = [NSArray yy_modelArrayWithClass:[YLQuestion class] json:json];
    }
    
    return _datas;
}

@end
