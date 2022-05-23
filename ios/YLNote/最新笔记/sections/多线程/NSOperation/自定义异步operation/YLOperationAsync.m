//
//  YLOperationAsync.m
//  YLNote
//
//  Created by tangh on 2022/2/23.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLOperationAsync.h"
#import <UIKit/UIImage.h>
static NSString * const kYLOperationAsyncLockName = @"yl.thread.operation.async.lock";

@interface YLOperationAsync ()
@property (nonatomic, readwrite, getter=isExecuting) BOOL executing;
@property (nonatomic, readwrite, getter=isFinished) BOOL finished;
@property (nonatomic, strong) NSRecursiveLock *lock;
@property (readwrite, nonatomic, strong) NSURLSessionDataTask *session;
@property (readwrite, nonatomic, strong) NSURLRequest *request;
/**
 The run loop modes in which the operation will run on the network thread. By default, this is a single-member set containing `NSRunLoopCommonModes`.
 */
@property (nonatomic, strong) NSSet *runLoopModes;

@end

@implementation YLOperationAsync

@synthesize executing = _executing;
@synthesize finished = _finished;

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"YLOperationAsyncRequestThread"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

+ (NSThread *)networkRequestThread {
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });

    return _networkRequestThread;
}

- (instancetype)init NS_UNAVAILABLE
{
    return nil;
}

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest {
    NSParameterAssert(urlRequest);

    self = [super init];
    if (!self) {
        return nil;
    }


    self.lock = [[NSRecursiveLock alloc] init];
    self.lock.name = kYLOperationAsyncLockName;

    self.runLoopModes = [NSSet setWithObject:NSRunLoopCommonModes];
    self.request = urlRequest;

    return self;

}
#pragma mark - 重写start方法开启任务下载
- (void)start {
    [self.lock lock];
    if ([self isCancelled]) {
        [self performSelector:@selector(cancelConnection) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    } else if ([self isReady]) {
        self.executing = YES;
        [self performSelector:@selector(operationDidStart) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    }
    [self.lock unlock];
}

- (void)operationDidStart {
    [self.lock lock];
    if (![self isCancelled]) {
        self.session = [[NSURLSession sharedSession] dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            sleep(3);
            [self done];
            if (!error && data) {
                self.completionHandler(YLOperationAsyncSessionResultSuccess, nil, data);
            } else {
                if (self.session.error.code == NSURLErrorCancelled) {
                    NSLog(@"%@: session completionHandler",self.opID);
                    self.completionHandler(YLOperationAsyncSessionResultCanceled, error, nil);
                } else {
                    self.completionHandler(YLOperationAsyncSessionResultFailure, error, nil);
                }
            }
        }];
        [self.session resume];
    } else {
        [self performSelector:@selector(cancelConnection) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    }
    [self.lock unlock];
}

- (void)cancelConnection {
    NSDictionary *userInfo = nil;
    if ([self.request URL]) {
        userInfo = @{NSURLErrorFailingURLErrorKey : [self.request URL]};
    }
    NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCancelled userInfo:userInfo];
    NSLog(@"%@：当前状态: [%d,%d,%d]",self.opID,self.isExecuting,self.isCancelled,self.isFinished);
    if (![self isFinished]) {
        if (self.session) {
            [self.session cancel];

        } else {
            NSLog(@"%@: session ",self.opID);
            [self done];
            self.completionHandler(YLOperationAsyncSessionResultCanceled, error, nil);
        }
    } else {
        NSLog(@"%@: 这里是什么状态 %@",self.opID,self.description);

    }

}

- (void)main {
    NSLog(@"哈喽啊： %s",__FUNCTION__);
}


//- (void)main {
//    @try {
//        NSLog(@"Start executing %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread]);
//
//        sleep(3);
//
//        [self willChangeValueForKey:@"isExecuting"];
//        _executing = NO;
//        [self didChangeValueForKey:@"isExecuting"];
//
//        [self willChangeValueForKey:@"isFinished"];
//        _finished  = YES;
//        [self didChangeValueForKey:@"isFinished"];
//
//        NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
//        
//
//    }
//    @catch (NSException *exception) {
//        NSLog(@"Exception: %@", exception);
//    }
//}


#pragma mark - 任务完成标记
- (void)done{
    self.executing = NO;
    self.finished = YES;
}

#pragma mark - 固定要重写的setter/getter
- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];

}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

@end
