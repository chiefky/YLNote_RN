//
//  YLBlockTestViewController.m
//  YLNote
//
//  Created by tangh on 2022/3/3.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLBlockTestViewController.h"
#import <objc/runtime.h>

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

/// block作为API参数，是否自动copy到堆区
- (void)testBlockCopy_as_apiPamater {
    
    int num = 8;
     
    void(^__weak weakBlock)(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) = ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *obj_num = (NSNumber*)obj;
        NSLog(@"num = %d",num + obj_num.intValue);
    };
    NSLog(@"weakBlock类型：%@",object_getClass(weakBlock));
    NSArray *array = @[@1,@4,@5];
    [array enumerateObjectsUsingBlock: weakBlock];
    NSLog(@"weakBlock类型：%@",object_getClass(weakBlock));
}
/// block作为gcd API参数，是否自动copy到堆区
- (void)testBlockCopy_as_gcdPamater {
    int num = 8;

    static dispatch_once_t onceToken;
    void(^__weak weakBlock)(void) = ^{
        NSLog(@"num = %d",num);
    };
    NSLog(@"1.weakBlock类型：%@",object_getClass(weakBlock));
    dispatch_once(&onceToken, weakBlock);
    NSLog(@"2.weakBlock类型：%@",object_getClass(weakBlock));
            
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), weakBlock);
    NSLog(@"3.weakBlock类型：%@",object_getClass(weakBlock));

}

- (void)testBlock_change_muArray {
    NSMutableArray *nums = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5"]];
    void(^ myblock)(void) = ^{
        [nums addObject:@"6"];
        NSLog(@"in block: nums = %@",nums);
    };
    NSLog(@"out block: nums = %@",nums);
    myblock();
    NSLog(@"out block: nums = %@",nums);
}
#pragma mark - override
- (NSString *)fileName {
    return @"block_test";
}

@end
