//
//  YLBlockTypesViewController.m
//  YLNote
//
//  Created by tangh on 2022/3/3.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLBlockTypesViewController.h"
#import <objc/runtime.h>

//static NSInteger static_global_num_blockTypes = 10;// 静态全局变量
//NSInteger global_num = 10; // 全局变量
typedef void(^YLTypesBlock)(void);

@interface YLBlockTypesViewController ()
@property(nonatomic,strong) YLTypesBlock strongBlock;
@property(nonatomic,copy) YLTypesBlock copyBlock;
@property(nonatomic,weak) YLTypesBlock weakBlock;

@end

@implementation YLBlockTypesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - funcs
/// __NSGlobalBlock__
/**
 - - 在block内部不使用外部变量 or 只使用全局变量或者静态变量
 */
- (void)testBlock_Global {
    static NSInteger static_local_num = 100;
    void(^hello)(void) = ^{
        
    };
    NSLog(@"`默认` block类型：%@",object_getClass(hello));

    self.weakBlock = ^{
        
    };
    NSLog(@"`weak` block类型：%@",object_getClass(self.weakBlock));

    self.strongBlock = ^{
        
    };
    NSLog(@"`strong` block类型：%@",object_getClass(self.strongBlock));

    self.strongBlock = ^{
        static_local_num = 102;
    };
    NSLog(@"`strong` block类型：%@",object_getClass(self.strongBlock));

    self.copyBlock = ^{
        
    };
    NSLog(@"`copy` block类型：%@",object_getClass(self.copyBlock));
    
    self.copyBlock = ^{
        static_local_num = 102;
    };
    NSLog(@"`copy` block类型：%@",object_getClass(self.copyBlock));


}

/// __NSStackBlock__
/**
 - - 前提：在block内部只能使用外部变量或OC属性，不能使用静态变量和全局变量，并且不对block赋值或者只能赋值给weak修饰的变量
 */
- (void)testBlock_Stack {
    NSInteger num = 3;
    __block NSString *nickName = @"张三";
  
    NSLog(@"使用局部变量，block类型：%@",[^{
        NSLog(@"使用局部变量: %ld",num);
    } class]);
    
    
    void(^ __weak doSpa)(void) = ^{
        NSLog(@"使用局部变量: %ld",num);
    };
    NSLog(@"`内部使用局部变量,赋值给__weak类型block` block类型：%@",object_getClass(doSpa));
    
    void(^ __weak doWeak)(void) = ^{
        NSLog(@"使用__block局部变量: %@",nickName);
    };
    NSLog(@"`内部使用__block变量,赋值给__weak类型block` block类型：%@",object_getClass(doWeak));

    // 赋值给weak修饰的变量
    self.weakBlock = ^{
        NSLog(@"使用局部变量: %ld",num);
    };
    NSLog(@"`内部使用局部变量,赋值给weak属性` block类型：%@",object_getClass(self.weakBlock)); //📢：这里是ISA指向的是 stack block，但是打印出来是malloc block
}

///__NSMallocBlock__
/**
 - - 前提：在block内部可以使用外部变量或OC属性，并且将block赋值给strong或copy修饰的变量
 */
- (void)testBlock_Malloc {
    NSString *name = @"Malloc_Block1";

    self.strongBlock = ^{
        NSLog(@"使用局部变量: %@",name);
    };
    NSLog(@"block类型：%@",object_getClass(self.strongBlock));

    self.copyBlock = ^{
        NSLog(@"使用局部变量: %@",name);
    };
    NSLog(@"block类型：%@",object_getClass(self.copyBlock));
}

#pragma mark - 作用域问题
- (void)testStackBlock_copy {
    int num = 8;
    void(^__weak weakBlock)(void) = nil;
    {
        void(^__weak weakBlock1)(void) = ^{
            NSLog(@"num = %d",num);
        };
        weakBlock = weakBlock1; //[weakBlock1 copy];
        /**
         测试：
         1." weakBlock = weakBlock1; "---正常执行
         两个block都是stack block，都存储在栈区；栈区空间是方法体空间，中间的'{}'表示匿名作用域，（C语言中介绍）栈存储期间匿名作用域的变量超出匿名作用域不一定立即释放；
         2. "weakBlock = [weakBlock1 copy];"---崩溃
         经过copy后 weakBlock指向的是堆区的空间,此空间在给weakBlock赋值前被ARC插入的release释放掉，所以weakBlock为null;
         超出"}"调用weakBlock(),相当于访问了野指针所以会崩溃。
         */

    }
    weakBlock();
}

- (void)runParameterBlock:(void(^)(void))blk {
    NSLog(@"block作为参数传递，其类型是：%@",object_getClass(blk));
    NSLog(@"blk 的isa是__NSStackBlock__,👆🏻打印结果是__NSMallocBlock__");
    blk();
}

- (void)testStackBlock_non_copy {
    int num = 8;
    [self runParameterBlock:^{
        NSLog(@"num = %d",num);
    }];
}

#pragma mark - override
- (NSString *)fileName {
    return @"block_types";
}



@end
