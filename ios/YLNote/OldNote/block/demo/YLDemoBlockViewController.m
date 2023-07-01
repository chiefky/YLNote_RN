//
//  YLDemoBlockViewController.m
//  YLNote
//
//  Created by tangh on 2021/4/6.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLDemoBlockViewController.h"
#import <Masonry/Masonry.h>
// static 变量的生命周期：APP的生命周期
static YLDemoBlockViewController *staticSelf_;

@interface YLDemoBlockViewController ()

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,copy) dispatch_block_t doWork;
@property (nonatomic,copy) dispatch_block_t doStudent;

@end

@implementation YLDemoBlockViewController

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *butn = [UIButton buttonWithType:UIButtonTypeCustom];
    [butn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butn];
    [butn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [butn setTitle:@"TEST" forState:UIControlStateNormal];
    [butn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
}

- (void)clickAction:(UIButton *)sender {
    [self test_weak_strong_dance];
}

#pragma mark - 输出结果
/// 1,3,4
- (void)test_block_retainCount_1 {
    NSObject *obj = [NSObject new];
    NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)(obj))); // ---- 1
    
    void(^ __strong strongBlock)(void) = ^{
        // 遇强捕强，遇弱捕弱 (遇到strong类型变量block捕获的obj也是strong，遇到weak类型变量block捕获的obj就是weak) ---- 此处是strong +1 == 2
        // 由stack copy到堆区时，会将所有变量重新copy到新malloc的内存区域，---此处copy操作引起再次计数+1 == 3
        NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)(obj))); // ---- 3
    };
    strongBlock(); // 堆区block
    
    void(^ __weak weakBlock)(void) = ^{
        // 遇强捕强，遇弱捕弱 (遇到strong类型变量block捕获的obj也是strong，遇到weak类型变量block捕获的obj就是weak) ---- 此处是strong +1 == 4
        NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)(obj)));
    };
    weakBlock();

}

/// 1,2,2
- (void)test_block_retainCount_2 {
        NSObject *obj = [NSObject new];
        NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)(obj))); // ---- 1
        __weak NSObject *weakObj = obj;
        void(^ __strong strongBlock)(void) = ^{
            // 遇强捕强，遇弱捕弱 (遇到strong类型变量block捕获的obj也是strong，遇到weak类型变量block捕获的obj就是weak) ---- 此处是weak obj 引用计数不变
            // 由stack copy到堆区时，会将所有变量重新copy到新malloc的内存区域，---此处copy操作引起再次计数+1 == 2

            NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)(weakObj)));
        };
    strongBlock();
        
        void(^ __weak weakBlock)(void) = ^{
            NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)(weakObj)));
        };
        weakBlock();

}

#pragma mark - block捕获变量
- (void)test_block_catch_crash {
    int a = 100;
    void (^ __weak weakBlock)(void) = ^{
        NSLog(@"%d",a);
    };
    dispatch_block_t blocck = ^{
        // 遇强捕强，遇弱捕弱： 捕获了一个弱引用的block，超出函数作用域之后weakblock被销毁，此处执行crash：EXC_BAD_ACCESS
        weakBlock();
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (3 * NSEC_PER_SEC)), dispatch_get_main_queue(), blocck);
}
- (void)test_block_catch {
    int a = 100;
    void (^ __weak weakBlock)(void) = ^{
        NSLog(@"%d",a);
    };
    dispatch_block_t blocck = ^{
        weakBlock();
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (3 * NSEC_PER_SEC)), dispatch_get_main_queue(), blocck);

    // sleep(3)
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
}

- (void)test_block_catch_strong {
    int a = 100;
    void (^ strongBlock)(void) = ^{
        NSLog(@"%d",a);
    };
    dispatch_block_t blocck = ^{
        // __strong 捕获进来，增加了 strongBlock的生命周期
        strongBlock();
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (3 * NSEC_PER_SEC)), dispatch_get_main_queue(), blocck);

}
#pragma mark - weak_strong_dance
- (void)test_weak_strong_dance {
    __weak typeof(self) weakSel = self;
    self.doWork = ^{
        __strong typeof(self) strongSelf = weakSel;
        weakSel.doStudent = ^{
            NSLog(@"%@",strongSelf);
        };
        weakSel.doStudent();
    };
//    self.doWork();
}

- (void)test_weak_strong_dance_2 {
    [[[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.raywenderlich.com"]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                NSLog(@"%@",self);
            });
    }] resume];
}

- (void)test_weak_strong_dance_3 {
    __weak typeof(self) weakSelf = self;
    [[[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.raywenderlich.com"]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __strong typeof(self) strongSelf = weakSelf;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                NSLog(@"%@",strongSelf);
            });
    }] resume];
}
#pragma mark - block 类型
- (void)test_block_type_1 {
    void(^ myBlock)(void) = ^{
        NSLog(@"--hello world");
    };
    myBlock(); // __NSGlobalBlock__
    
    int a = 0;
    void(^ __weak weakBlock)(void) = ^{
        NSLog(@"----%d",a);
    };
    weakBlock(); // stack block
    
    void (^__strong strongBlock)(void) = weakBlock; // 结构体 = 结构体；isa = isa;
    strongBlock(); // stack block
    
    void(^ __weak strongBlock1)(void) = ^{
        NSLog(@"----%d",a);
    };
    strongBlock1(); // __NSMallocBlock__

    void (^__strong strongBlock2)(void) = [weakBlock copy]; //
    strongBlock2(); // __NSMallocBlock__

}

/// b的值是否能正常打印？ （即：weakBlock1，weakBlock的生命周期？）
- (void)test_block_type_2 { // 栈帧，由高地址向低地址
    
    // 栈上的变量自动回收 (栈区作用域：函数{}内,栈上的变量生命周期与临时作用域无关)
    int a = 100;
    
    void(^ __weak weakBlock)(void) = nil;
    
    {
        int b = 2;
        void(^ __weak weakBlock1)(void) = ^{
            NSLog(@"a: %d;b: %d",a,b);
        };
        weakBlock = weakBlock1; // 两者都是 stack block

    }
    
    weakBlock();
}

/// b的值是否能正常打印？ （即：堆区block生命周期 == 临时作用域）
- (void)test_block_type_3 {
        int a = 100;
    
    void(^ __weak weakBlock)(void) = nil;
    
    {
        int b = 2;
        void(^ __strong strongBlock)(void) = ^{
            NSLog(@"a: %d;b: %d",a,b);
        };
        weakBlock = strongBlock; // 两者都是 malloc block;
        NSLog(@"hello");
        
        
        // 堆区block出作用域之前会执行 __block__release()
    }
    
    weakBlock(); // crash: EXC_BAD_ACCESS (strongblock 函数指针已置为nil)
}

#pragma mark - __weak 一定能打破循环引用吗
/// <#Description#>
- (void)test_weak {
    // __weak的作用：把weak修饰的变量放到弱引用列表里，（当变量的引用计数置为0后将变量置为nil）
    __weak typeof(self) weakSelf = self;
    staticSelf_ = weakSelf;
}

#pragma mark - lazy
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        [self.view addSubview:_table];
        [_table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _table;
}
@end
