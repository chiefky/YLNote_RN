//
//  YLOperationConcurrent.m
//  YLNote
//
//  Created by tangh on 2022/2/21.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLOperationConcurrent.h"
#import "UIKit/UIImage.h"
@interface YLOperationConcurrent ()
//@property (nonatomic, readwrite, getter=isExecuting) BOOL executing;
//@property (nonatomic, readwrite, getter=isFinished) BOOL finished;


@end

@implementation YLOperationConcurrent
@synthesize executing = _executing;
@synthesize finished = _finished;
@synthesize cancelled = _cancelled;

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - 重写start方法开启任务下载
- (void)start {
    if (self.isCancelled) {
        [self willChangeValueForKey:@"isCancelled"];
        _cancelled = YES;
        [self didChangeValueForKey:@"isCancelled"];

        return;
    }

    [self willChangeValueForKey:@"isExecuting"];

    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    _executing = YES;

    [self didChangeValueForKey:@"isExecuting"];
}


- (void)main {
    @try {
        NSLog(@"Start executing %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread]);

        sleep(3);

        [self willChangeValueForKey:@"isExecuting"];
        _executing = NO;
        [self didChangeValueForKey:@"isExecuting"];

        [self willChangeValueForKey:@"isFinished"];
        _finished  = YES;
        [self didChangeValueForKey:@"isFinished"];

        [self willChangeValueForKey:@"isCancelled"];
        _cancelled  = YES;
        [self didChangeValueForKey:@"isCancelled"];
        NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}

//- (void)start{
//    @autoreleasepool {
//        self.executing = YES;
//        if (self.isCancelled) {
//            [self done];
//            return;
//        }
//        // 任务
//        [self downloadPicWithUrlStr:self.url completionHandler:^(UIImage *img) {
//            [self done];
//            if (self.finishBlock) {
//                self.finishBlock(img);
//            }
//        }];
//    }
//}

#pragma mark - 下载图片
- (void)downloadPicWithUrlStr:(NSString *)urlStr completionHandler:(void(^)(UIImage *img))completionHandler{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error && data) {
            UIImage *image = [UIImage imageWithData:data];
            !completionHandler ? :completionHandler(image);
        }else{
            !completionHandler ? :completionHandler(nil);
        }
    }];
    [dataTask resume];
}

//#pragma mark - 任务完成标记
//- (void)done{
//    self.executing = NO;
//    self.finished = YES;
//}

#pragma mark - 固定要重写的setter/getter
- (id)init {
    self = [super init];
    if (self) {
        _executing = NO;
        _finished  = NO;
    }
    return self;
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

- (BOOL)isCancelled {
    return _cancelled;
}





@end
