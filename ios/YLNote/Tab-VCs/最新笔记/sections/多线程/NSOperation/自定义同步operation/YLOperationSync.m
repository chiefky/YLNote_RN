//
//  YLOperationSync.m
//  YLNote
//
//  Created by tangh on 2022/2/21.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLOperationSync.h"

@implementation YLOperationSync

- (void)main {
    @try {
        NSLog(@"Start executing %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread]);

        sleep(3);
        
        [self downloadPicWithUrlStr:self.url completionHandler:^(NSData *data) {
            if (self.finishBlock) {
                self.finishBlock(data);
            }
        }];

//        [self willChangeValueForKey:@"isExecuting"];
//        _executing = NO;
//        [self didChangeValueForKey:@"isExecuting"];
//
//        [self willChangeValueForKey:@"isFinished"];
//        _finished  = YES;
//        [self didChangeValueForKey:@"isFinished"];
//
        NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));


    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}

- (void)downloadPicWithUrlStr:(NSString *)urlStr completionHandler:(void(^)(NSData *data))completionHandler{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        sleep(3);
        if (!error && data) {
            !completionHandler ? :completionHandler(data);
        }else{
            !completionHandler ? :completionHandler(nil);
        }
    }];
    [dataTask resume];
}

@end
