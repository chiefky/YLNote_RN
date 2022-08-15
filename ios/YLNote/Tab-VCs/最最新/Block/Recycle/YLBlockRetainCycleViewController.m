//
//  YLBlockRetainCycleViewController.m
//  YLNote
//
//  Created by tangh on 2021/7/31.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLBlockRetainCycleViewController.h"
#import "YLProxy.h"
#import "YLNoteData.h"


typedef void(^YLDemoVoidBlock)(void);
typedef void(^YLDemoParameterBlock)(YLBlockRetainCycleViewController *);
typedef void(^YLDemoProxyBlock)(YLProxy *);

@interface YLBlockRetainCycleViewController ()

@property(nonatomic, copy) YLDemoParameterBlock yl_PBlock;
@property(nonatomic, copy) YLDemoVoidBlock yl_VBlock;
@property(nonatomic, copy) YLDemoProxyBlock yl_PoxBlock;

@end

@implementation YLBlockRetainCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 可造成循环引用的案例
- (void)testAllRetainCycleCases {
    // 1. delegate 使用了strong关键字，可能会造成循环引用
    // 2. block 内部直接使用了block的持有者，可能会造成循环引用
    // 3. NSTimer 使用了timer的 持有者作为target，可能会造成循环引用
}

#pragma mark - 解决Block循环引用的方案
/// 方案一：借助weak
- (void)testResolveBlockRecycle_weak {
    __weak typeof(self) weakSelf = self;
    self.yl_VBlock = ^{
        NSLog(@"demoName = %@",[weakSelf demoName]);
    };
    self.yl_VBlock();
}

/// 方案二：借助__block
- (void)testResolveBlockRecycle_block {
    __block YLBlockRetainCycleViewController *tmpVC = self;
    self.yl_VBlock = ^{
        NSLog(@"demoName = %@",[tmpVC demoName]);
        tmpVC = nil; // 📢：1.必须将变量置为nil
    };
    self.yl_VBlock(); // 📢：2.必须调用block
}

/// 方案三：借助参数
- (void)testResolveBlockRecycle_Parameter {
    
    self.yl_PBlock = ^(YLBlockRetainCycleViewController *vc) {
        NSLog(@"demoName = %@",[vc demoName]);
    };
    self.yl_PBlock(self);
}

/// 方案四：使用NSProxy（其实是借助参数传递中间者+中间者弱持有self就可以解决，完全可以不用消息转发）（使用Proxy的原理是：1.添加了一个中间者Proxy；2.Proxy持有一个弱引用对象，也就是响应方法的目标对象；3. 借助消息转发机制将消息传递给目标对象）
- (void)testResolveBlockRecycle_Rroxy {
    YLProxy *proxy = [YLProxy proxyWithTarget:self];
    self.yl_PoxBlock = ^(YLProxy *pox) {
        NSLog(@"demoName = %@",[pox.target demoName]);
    };
    self.yl_PoxBlock(proxy);
}

- (void)testReatinCycle_weak {
    
}

- (NSString *)demoName {
    return @"Block demo!!";
}

#pragma mark -lazy 数据源
- (NSString *)fileName {
    return @"block_recycle";
}

@end
