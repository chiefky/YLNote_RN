//
//  YLThreadTestViewController.m
//  YLNote
//
//  Created by tangh on 2022/2/15.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLThreadTestViewController.h"

@interface YLThreadTestViewController ()
@property (nonatomic, strong) NSString *string;

@end

@implementation YLThreadTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

#pragma mark - functions

/// "原子性和非原子性"
- (void)testPropertyNonAtomic {
    dispatch_queue_t queue = dispatch_queue_create("com.yuli.gcd.dispatch_queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 1; i <= 100000; i++) {
        
        dispatch_async(queue, ^{
            self.string = [NSString stringWithFormat:@"test_%d",i];
            NSLog(@"self.string: %@",self.string);
        });
        
    }
}

#pragma mark - 线程池最大并发数
/// 使用GCD,查看线程最大并发数(首次打印64条任务 --> maxCount==64)
- (void)testMaxCount_GCD {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);//获取指定优先级的全局并发队列（flag填0即可，仅预留的参数，使用其他值可能会返回null）
    for (NSUInteger i = 1; i< 300; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%ld: %@",i,[NSThread currentThread]);
            [NSThread sleepForTimeInterval:15];
        });
    }
    
}
    

/// 使用NSOperation,查看线程最大并发数(首次打印64条任务 --> maxCount==64)
- (void)testMaxCount_NSOperation {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 300;
    for (NSUInteger i = 1; i<= 300; i++) {
        [queue addOperationWithBlock:^{
            NSLog(@"%ld: %@",i,[NSThread currentThread]);
            [NSThread sleepForTimeInterval:15];
        }];
    }
}
#pragma mark - cell data
- (NSString *)fileName {
    return @"thread_test";
}

@end
