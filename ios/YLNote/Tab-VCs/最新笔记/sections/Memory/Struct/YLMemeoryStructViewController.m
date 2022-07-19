//
//  YLMemeoryStructViewController.m
//  YLNote
//
//  Created by tangh on 2021/8/11.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLMemeoryStructViewController.h"
#import "YLAlertManager.h"
#import "YLAnimal.h"
#import "YLNoteData.h"

@interface YLMemeoryStructViewController ()

@end

@implementation YLMemeoryStructViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/// 测试关联返回类型or非关联返回类型,打开注释代码，编译报错（name not found of type 'id_Nonnull'）
- (void)testId_instancetype {
    NSString *temp;
    temp = [YLAnimal allocTestObject].name;
    temp = [YLAnimal newTestObject].name;
    //    temp = [YLAnimal testIdObject].name;
    temp = [YLAnimal testInstanceObject].name;
    //    id proxy = [NSProxy alloc];
    
    NSLog(@"打开注释重新编译一遍");
    [YLAlertManager showAlertWithTitle:nil message:@"打开注释重新编译一遍" actionTitle:@"OK" handler:nil];
}

/// alloc 原理探索
- (void)testAlloc {
    
    NSObject *object1 = [NSObject alloc];
    YLAnimal *object2 = [YLAnimal alloc];
    
}

- (void)testRlease {
    __weak id weakObj = nil;
    id obj = nil;
    {
        NSString *numS = @"2";
        weakObj = numS;
        NSObject *tmp = [NSObject alloc];
        obj = tmp;
    }
    NSLog(@"%@--%@",obj,weakObj);
}


/// 查看cache_t底层结构(使用objc-818源码调试)
- (void)testCache_t {
    YLAnimal *animal  = [YLAnimal alloc];
    Class aniClass = [YLAnimal class];  // objc_clas
    [animal sayA];
    [animal sayB];
    struct yl_objc_class *yl_aClass = (__bridge struct yl_objc_class *)(aniClass);
    NSLog(@"%hu - %u",yl_aClass->cache._occupied,yl_aClass->cache._mask);
    for (mask_t i = 0; i<yl_aClass->cache._mask; i++) {
        // 打印获取的 bucket
        struct yl_bucket_t bucket = yl_aClass->cache._buckets[i];
        NSLog(@"%@ - %p",NSStringFromSelector(bucket._sel),bucket._imp);
    }
    
    
    NSLog(@"Hello, World!");
    
}
//查看data_bits_t底层结构(使用objc-818源码调试)
- (void)testData_bits {
    Class cls = [YLAnimal class];
    NSLog(@"%p", cls);
}

#pragma mark - lazy 数据源
- (NSString *)fileName {
    return @"memory_struct";
}


@end
