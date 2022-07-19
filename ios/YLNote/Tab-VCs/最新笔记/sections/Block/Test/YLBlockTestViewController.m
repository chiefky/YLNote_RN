//
//  YLBlockTestViewController.m
//  YLNote
//
//  Created by tangh on 2022/3/3.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLBlockTestViewController.h"

@interface YLBlockTestViewController ()

@end

@implementation YLBlockTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - funcs
- (void)testStackBlock_copy {
    int num = 8;
    void(^__weak weakBlock)(void) = nil;
    {
        void(^__weak weakBlock1)(void) = ^{
            NSLog(@"num = %d",num);
        };
        weakBlock = weakBlock1;// [weakBlock1 copy];
    }
    
    weakBlock();
}

#pragma mark - override
- (NSString *)fileName {
    return @"block_test";
}

@end
