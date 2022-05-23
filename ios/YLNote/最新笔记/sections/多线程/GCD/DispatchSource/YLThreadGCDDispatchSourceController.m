//
//  YLThreadGCDDispatchSourceController.m
//  YLNote
//
//  Created by tangh on 2022/3/1.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLThreadGCDDispatchSourceController.h"

@interface YLThreadGCDDispatchSourceController ()

@end

@implementation YLThreadGCDDispatchSourceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - funcs
- (void)testGCD_source_timer {
    dispatch_queue_t queue = dispatch_queue_create("com.tangh.test", DISPATCH_QUEUE_CONCURRENT);

    dispatch_source_t  source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(source, dispatch_walltime(NULL, 0),  5ull * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(source, ^{
         [self sayHello];
    });

    dispatch_source_set_cancel_handler(source, ^{
          NSLog(@"");
    });

     dispatch_resume(source);
}

- (void)sayHello {
    NSLog(@"🍎----- Hello");
}

#pragma mark - lazy
- (NSString *)fileName {
    return @"thread_gcd_source";
}

@end
