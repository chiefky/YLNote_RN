//
//  YLRuntimeMsgFwd2Controller.m
//  YLNote
//
//  Created by tangh on 2021/7/25.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLRuntimeMsgFwd2Controller.h"
#import "YLProxy.h"
@interface YLRuntimeMsgFwd2Controller ()

@property(nonatomic,strong) NSTimer *leakerTimer;
@property(nonatomic,strong) NSTimer *proxyTimer;
@property(nonatomic,strong) NSTimer *targetTimer;

@end

@implementation YLRuntimeMsgFwd2Controller

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
//    [self.leakerTimer invalidate];
    [self.proxyTimer invalidate];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NSRunLoop mainRunLoop] addTimer:self.leakerTimer forMode:NSRunLoopCommonModes];
    [[NSRunLoop mainRunLoop] addTimer:self.proxyTimer forMode:NSRunLoopCommonModes];
    
}

- (void)doAction:(NSTimer *)timer {
    NSLog(@"%@: %@",timer.userInfo,[NSDate date]);
}


- (void)doAction {
    NSLog(@"say Hello!");
}

#pragma mark - lazy
- (NSTimer *)leakerTimer {
    if (!_leakerTimer) {
        _leakerTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(doAction:) userInfo:@"LEAKER" repeats:YES];
    }
    return _leakerTimer;
}

- (NSTimer *)proxyTimer {
    if (!_proxyTimer) {
        _proxyTimer = [NSTimer timerWithTimeInterval:1 target:[YLProxy proxyWithTarget:self] selector:@selector(doAction:) userInfo:@"PORXY_weak" repeats:YES];
    }
    return _proxyTimer;
}

@end
