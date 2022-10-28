//
//  YLThreadNSThreadViewController.m
//  YLNote
//
//  Created by tangh on 2022/2/20.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLThreadNSThreadViewController.h"

@interface YLThreadNSThreadViewController ()
@property (nonatomic,strong) NSThread *mythread;
@end

@implementation YLThreadNSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - NSThread创建线程

/// 1. alloca init创建NSTread对象，必须调用start方法开始，并且只能传一个参数object
/// initWithTarget:
/// 或者 initWithBlock:
- (void)testCreate_init {
 
    //打印当前线程
    NSLog(@"开始：%@   优先级：%ld", [NSThread currentThread], [NSThread currentThread].qualityOfService);
    
     self.mythread = [[NSThread alloc] initWithTarget:self selector:@selector(doThreadAction:) object:@"test"];
    //    NSThread *thread = [[NSThread alloc] initWithBlock:^{}];
    self.mythread.name = @"testNSThread";
    [self.mythread start];
    
}

/// 2.detachNew直接创建并启动线程 ，
/// 或者使用block方式 ：       [NSThread detachNewThreadWithBlock:^{}];
- (void)testCreate_detach {
 
    //打印当前线程
    NSLog(@"开始：%@   优先级：%ld", [NSThread currentThread], [NSThread currentThread].qualityOfService);
    [NSThread detachNewThreadSelector:@selector(doThreadAction:) toTarget:self withObject:@"test"];
}

/// 3.隐式直接创建
- (void)testCreate_perform {
 
    //打印当前线程
    NSLog(@"开始：%@   优先级：%ld", [NSThread currentThread], [NSThread currentThread].qualityOfService);
    //3.隐式直接创建
    [self performSelectorInBackground:@selector(doThreadAction:) withObject:@"test"];
    NSLog(@"结束：%@", [NSThread currentThread]);

}

#pragma mark - action
- (void)doThreadAction:(id)object {
    NSLog(@"子线程运行：%@ %@  优先级：%ld", [NSThread currentThread], object, [NSThread currentThread].qualityOfService);
}

- (NSString *)fileName {
    return @"thread_nshread";
}

@end
