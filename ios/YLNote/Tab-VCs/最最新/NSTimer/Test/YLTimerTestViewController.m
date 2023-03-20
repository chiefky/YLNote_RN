//
//  YLTimerTestViewController.m
//  YLNote
//
//  Created by tangh on 2022/3/3.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLTimerTestViewController.h"
#import <objc/runtime.h>

@interface YLTimerTestViewController ()

@property (nonatomic,unsafe_unretained) CGFloat myName;

@end

@implementation YLTimerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myName = 88;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"------：%@",self.myName);
}

#pragma mark - funcs


#pragma mark - override
- (NSString *)fileName {
    return @"timer_test";
}

@end
