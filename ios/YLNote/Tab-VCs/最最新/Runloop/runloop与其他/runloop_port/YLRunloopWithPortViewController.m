//
//  YLRunloopWithPortViewController.m
//  YLNote
//
//  Created by tangh on 2022/2/14.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLRunloopWithPortViewController.h"
#import "YLThread.h"
#import "YLRunloopDoggy.h"
static NSInteger kMsg1 = 100;
static NSInteger kMsg2 = 101;

@interface YLRunloopWithPortViewController ()<NSMachPortDelegate>

@property(nonatomic,strong) NSMachPort *myPort;
@property(nonatomic,strong) YLRunloopDoggy *work;

@end

@implementation YLRunloopWithPortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - functions
- (void)testMsgBwnThread {
    NSLog(@"current thread is %@.", [NSThread currentThread]);
    
    self.myPort = [NSMachPort port];
    self.myPort.delegate = self;
    
    [[NSRunLoop currentRunLoop] addPort:self.myPort forMode:NSDefaultRunLoopMode];
    
    self.work = [[YLRunloopDoggy alloc] init];
    [YLThread detachNewThreadSelector:@selector(launchThreadWithPort:) toTarget:self.work withObject:self.myPort];
}

- (void)testMsgBwnThread2 {
    
}

#pragma mark - NSMachPortDelegate
- (void)handlePortMessage:(NSMessagePort *)message
{
    NSLog(@"接受到子线程传递的消息。%@", message);
    
    NSUInteger msgId = [[message valueForKeyPath:@"msgid"] integerValue];
    NSMachPort *localPort = [message valueForKeyPath:@"localPort"];
    NSMachPort *remotePort = [message valueForKeyPath:@"remotePort"];
    NSMutableArray *componts = [message valueForKey:@"components"];
    for (NSData *data in componts) {
        NSLog(@"data is %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }
    
    if (msgId == kMsg1) {
        [remotePort sendBeforeDate:[NSDate date] msgid:kMsg2 components:nil from:localPort reserved:0];
    }
}

#pragma overide
- (NSString *)fileName {
    return @"runloop_port";
}

@end
