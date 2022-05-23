//
//  YLThreadGCDDispatchGroupController.m
//  YLNote
//
//  Created by tangh on 2022/2/26.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLThreadGCDDispatchGroupController.h"
#import <AFNetworking/AFNetworking.h>
@interface YLThreadGCDDispatchGroupController ()

@end

@implementation YLThreadGCDDispatchGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - func
/// 多线程同步-dispatch_group_notify
- (void)testGCD_group_nofitfy {
    dispatch_queue_t queue = dispatch_queue_create("yuli.thread.gcd.group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    dispatch_group_enter(group);
    dispatch_group_enter(group);
    [manager GET:@"http://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        NSLog(@"🍎 success: %@", [NSThread currentThread]);
        dispatch_group_leave(group);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"🍎 failure: %@", [NSThread currentThread]);
        dispatch_group_leave(group);
    }];
    
    [manager GET:@"http://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 请求成功
        NSLog(@"🍑 success: %@", [NSThread currentThread]);
        dispatch_group_leave(group);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"🍑 failure: %@", [NSThread currentThread]);
        dispatch_group_leave(group);
        
    }];
        
   dispatch_group_notify(group, queue, ^{
       NSLog(@"捕获所有宝宝🍎🍑...");
   });
}

/// 多线程同步--dispatch_group_wait
- (void)testGCD_group_wait {
    dispatch_queue_t queue = dispatch_queue_create("yuli.thread.gcd.group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    dispatch_group_enter(group);
    dispatch_group_enter(group);
    dispatch_group_enter(group);
    [manager GET:@"http://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        NSLog(@"🍎 success: %@", [NSThread currentThread]);
        dispatch_group_leave(group);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"🍎 failure: %@", [NSThread currentThread]);
        dispatch_group_leave(group);
    }];
    
    [manager GET:@"http://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        NSLog(@"🍇 success: %@", [NSThread currentThread]);
        dispatch_group_leave(group);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"🍇 success: %@", [NSThread currentThread]);
        dispatch_group_leave(group);
    }];

    dispatch_async(queue, ^{
        long result = dispatch_group_wait(group, DISPATCH_TIME_FOREVER); // 注意：暂停当前线程（阻塞当前线程），等待指定的 group 中的任务执行完成后，才会往下继续执行
        if (result == 0) {
            NSLog(@"捕获所有宝宝🍎🍇...");
        } else {
            NSLog(@"存在未捕获的宝宝...");
        }
    });

}

#pragma mark - lazy
- (NSString *)fileName {
    return @"thread_gcd_group";
}
@end
