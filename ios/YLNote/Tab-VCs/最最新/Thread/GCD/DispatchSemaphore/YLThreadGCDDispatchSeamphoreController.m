//
//  YLThreadGCDDispatchSeamphoreController.m
//  YLNote
//
//  Created by tangh on 2021/11/9.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLThreadGCDDispatchSeamphoreController.h"
#import <AFNetworking/AFNetworking.h>
dispatch_semaphore_t semaphoreLock = nil;

@interface YLThreadGCDDispatchSeamphoreController ()
@property (nonatomic,assign) NSInteger tickets;
@end

@implementation YLThreadGCDDispatchSeamphoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tickets = 10000;
    semaphoreLock = dispatch_semaphore_create(1);

}

/// 多线程同步--dispatch_group_wait
- (void)testGCD_seamphore_sync {
    dispatch_queue_t queue = dispatch_queue_create("yuli.thread.gcd.group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [[AFHTTPSessionManager manager] GET:@"http://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        NSLog(@"🍎 success: %@", [NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"🍎 failure: %@", [NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    }];
    sleep(3);
    [[AFHTTPSessionManager manager] GET:@"http://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        NSLog(@"🍇 success: %@", [NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"🍇 success: %@", [NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
        
    }];
    dispatch_async(queue, ^{
        long result =
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        result = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        if (result == 0) {
            NSLog(@"捕获所有宝宝🍎🍇...");
        } else {
            NSLog(@"存在未捕获的宝宝...");
        }
        
    });
    
}

- (void)testGCD_seamphore_lock {
    dispatch_queue_t queue = dispatch_queue_create("yuli.seamphore.gcd.thread", DISPATCH_QUEUE_CONCURRENT);
    // 创建 信号量 线程锁
    NSInteger i = self.tickets;
    while (i>0) {
        dispatch_async(queue, ^{
            [self saleTicketSafe];
        });
        i--;
    }
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"当前票数：%ld",self.tickets);
    });
    NSLog(@"say %@",self.tickets > 0 ? @"有余票" : @"票卖光了");
}

- (void)saleTicketSafe {
    // 相当于加锁：初始值为1，此处减1后，其他线程无法同时访问临界变量
    dispatch_semaphore_wait(semaphoreLock, DISPATCH_TIME_FOREVER);
    
    // 需要保证线程安全的操作
    self.tickets -= 1;
    NSLog(@"🍎--------%ld",self.tickets);
    
    // 相当于解锁：信号量+1，其他线程可以访问临界资源。
    dispatch_semaphore_signal(semaphoreLock);
    
}

#pragma mark - cell data
- (NSString *)fileName {
    return @"thread_gcd_semaphore";
}

@end

