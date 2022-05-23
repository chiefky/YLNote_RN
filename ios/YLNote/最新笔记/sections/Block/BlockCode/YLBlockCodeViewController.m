//
//  YLBlockCodeViewController.m
//  YLNote
//
//  Created by tangh on 2021/7/31.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLBlockCodeViewController.h"
#import "YLNoteData.h"
//全局静态变量
//extern作用:只是用来获取全局变量(包括全局静态变量)的值，不能用于定义变量
extern NSString *externString = @"dddd";

typedef void(^BehaviorBlock)(void);

@interface YLBlockCodeViewController (){
    __block NSString *titleName;
}

@property(nonatomic,strong) BehaviorBlock doWork;
@property(nonatomic,copy) BehaviorBlock doSports;
@property(nonatomic,weak) BehaviorBlock doShopping;


@end

@implementation YLBlockCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/// 堆区、栈区block捕获strong变量
/// 打印结果： "1/3/4"
- (void)testBlock_catch_strong {
//    NSObject *obj = [NSObject new];
    NSMutableArray *muArr = [[NSMutableArray alloc] initWithObjects:@"1",@"2", nil];
    NSMutableArray *muArr2 = muArr;
    NSLog(@"obj 引用计数：%ld",CFGetRetainCount((__bridge  CFTypeRef)muArr));
    // 由栈区copy进堆区，obj +1
//    void(^strongBlock)(void) = ^{
//        // 捕获外部变量obj ；强持有，+1；
//        NSLog(@"obj 引用计数：%ld",CFGetRetainCount((__bridge  CFTypeRef)muArr));
//    };
//    strongBlock();
    
    __weak void(^weakBlock)(void) = ^{
        NSLog(@"obj 引用计数：%ld",CFGetRetainCount((__bridge  CFTypeRef)muArr));
    };
    weakBlock();
}

/// 栈区block捕获weak变量
- (void)testBlock_catch_weak {
    NSString *name = @"Statck block";
    void(^__weak block)(void) = ^{
        NSLog(@"name = %@",name);
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block(); // 捕获进来的是weak block，3秒后block超出栈帧空间，自动释放掉；所以引起崩溃
    });
}


/// 堆区、栈区block捕获__block变量
/// 打印结果： "1/3/4"
- (void)testBlock_catch_block {
    __block NSMutableArray *muArr = [[NSMutableArray alloc] initWithObjects:@"1",@"2", nil];
    NSLog(@"obj 引用计数：%ld",CFGetRetainCount((__bridge  CFTypeRef)muArr));
    // 由栈区copy进堆区，obj +1
    void(^strongBlock)(void) = ^{
        // 捕获外部变量obj ；强持有，+1；
        muArr = [@[@"3",@"0",@"9"] mutableCopy];
        NSLog(@"obj 引用计数：%ld",CFGetRetainCount((__bridge  CFTypeRef)muArr));
        NSLog(@"strongBlock: %@",muArr);
    };
    strongBlock();
    
    __weak void(^weakBlock)(void) = ^{
        NSLog(@"obj 引用计数：%ld",CFGetRetainCount((__bridge  CFTypeRef)muArr));
        NSLog(@"weakBlock: %@",muArr);
    };
    weakBlock();
    
    NSLog(@"%@",muArr);
}

/// 面试题：是否存在问题？答：dowork执行后，dosports产生了循环引用;内存泄漏
- (void)testBlock_weak_strong {
    __weak typeof(self) weakSelf = self;
    NSLog(@"obj 引用计数：%ld",CFGetRetainCount((__bridge  CFTypeRef)self));
    
    self.doWork = ^{
        // 刚进来引用计数没有变化，没产生强引用
        
        __strong typeof(self) strongSelf = weakSelf; // 执行完这一步，把self赋值给strongSelf产生了强引用（其实是，dowork捕获了weak变量，然后声明了一个strong变量强持有weak变量）
        weakSelf.doSports = ^{
            // self --> doSports --> self
            NSLog(@"obj 引用计数：%ld",CFGetRetainCount((__bridge  CFTypeRef)strongSelf)); // 捕获strongSelf，造成强引用
        };
        weakSelf.doSports();
    };
    self.doWork();
}

- (void)testBlockKeyWord_block {
    

}

-(void) testStackHeap {
    NSString *string = @"dddd";
    NSLog(@"dddd -> %p",@"dddd"); //dddd是常量字符串，存在常量区
    NSLog(@"string->%p",string); //string指针存在栈区， 指针指向常量区
    NSLog(@"&string->%p",&string); //string指针存在栈区， 指针指向常量区
    NSLog(@"Int -> %u",0xa5a5a5a5);
    NSLog(@"\n**************************");

    //string2在栈中，指向堆区的地址
    NSObject *obj = [[NSObject alloc] init];//[[NSString alloc] initWithFormat:@"dddd"];
    NSLog(@"obj-> %p",obj);
    NSLog(@"&obj-> %p",&obj);

    NSLog(@"\n**************************");
    NSString *string3 = [NSString stringWithFormat:@"dddd"];
    NSLog(@"string3 -> %p", string3);
    //    string3 = nil;
    NSLog(@"string3 -> %p", string3);
    //string2 和 string3 都是指向同一地址
    //    string2 = nil;
    NSString *string4 = [string3 copy];
    //string4 也和 string2,3地址一样
    NSLog(@"string4 -> %p", string4);
    
    //externString是指向常量区
    NSLog(@"externString ->%p", externString);
}
/// block捕获变量，原则：（遇强捕强，遇弱捕弱）
- (void)testBlock_catch {
    
}

#pragma mark -lazy 数据源
- (NSString *)fileName {
    return @"block_code";
}

@end
