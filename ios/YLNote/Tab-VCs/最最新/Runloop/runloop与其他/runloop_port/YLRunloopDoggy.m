//
//  YLRunloopDoggy.m
//  YLNote
//
//  Created by tangh on 2022/2/14.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLRunloopDoggy.h"

#define kMsg1 100
#define kMsg2 101

@interface YLRunloopDoggy () <NSMachPortDelegate>

@property (nonatomic, strong) NSPort *remotePort;
@property (nonatomic, strong) NSPort *myPort;

@end

@implementation YLRunloopDoggy

- (void)launchThreadWithPort:(NSPort *)port
{
    @autoreleasepool {
        self.remotePort = port;
        
        [[NSThread currentThread] setName:@"YLRunloopDoggy"];
        
        NSLog(@"launchThreadWithPort thread is %@.", [NSThread currentThread]);
        
        self.myPort = [NSMachPort port];
        self.myPort.delegate = self;
        
        [[NSRunLoop currentRunLoop] addPort:self.myPort forMode:NSDefaultRunLoopMode];
        
        [self sendPortMessage];
        
        [[NSRunLoop currentRunLoop] run];
    }
}

- (void)sendPortMessage
{
    NSData *data1 = [@"doggy" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data2 = [@"hello" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:@[@"1", @"2"]];
    [self.remotePort sendBeforeDate:[NSDate date] msgid:kMsg1 components:array from:self.myPort reserved:0];
}

#pragma mark - NSPortDelegate
- (void)handlePortMessage:(NSMessagePort *)message
{
    NSLog(@"接受到父类的消息。。。%@。", message);
}
@end

