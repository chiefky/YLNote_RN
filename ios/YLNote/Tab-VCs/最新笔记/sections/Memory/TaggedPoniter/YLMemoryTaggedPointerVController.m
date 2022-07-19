//
//  YLMemoryTaggedPointerVController.m
//  YLNote
//
//  Created by tangh on 2021/8/4.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLMemoryTaggedPointerVController.h"
#import <objc/runtime.h>
#import "YLNoteData.h"
#import "YLPerson.h"

extern uintptr_t objc_debug_taggedpointer_obfuscator;

static inline uintptr_t
_objc_decodeTaggedPointer(const void * _Nullable ptr)
{
    return (uintptr_t)ptr ^ objc_debug_taggedpointer_obfuscator;
}

char s[] = "aaaa";;
static NSObject *staticObj;

@interface YLMemoryTaggedPointerVController ()

@end

@implementation YLMemoryTaggedPointerVController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)testMem {
    UIView *a = [UIView new];
    
}

/// 验证TaggedPointer（64位地址存储内容，分iOS14以前和以后）
/// 混淆原理：使用一个随机数objc_debug_taggedpointer_obfuscator对真正的内存地址异或操作--> TaggedPointer的一个处理后的地址
- (void)testObject_TaggedPointer {
    NSNumber *number = [NSNumber numberWithInteger:9999999999999];
    NSNumber *shortNumber = [NSNumber numberWithShort:1];
    NSNumber *intNumber = @1;//[NSNumber numberWithInt:1];
    NSNumber *floatNumber = [NSNumber numberWithFloat:1.0];
    NSNumber *longNumber = [NSNumber numberWithLong:1];
    NSNumber *doubleNumber = [NSNumber numberWithDouble:1.0];
    NSLog(@"%@,%p，解码出来的值(倒数第一位是类型,倒数第二位是值)：0x%lx",number,&number,_objc_decodeTaggedPointer((__bridge const void * _Nullable)number));

    NSLog(@"%@,%p，解码出来的值(倒数第一位是类型,倒数第二位是值)：0x%lx",shortNumber,&shortNumber,_objc_decodeTaggedPointer((__bridge const void * _Nullable)shortNumber));
    NSLog(@"%@,%p，解码出来的值(倒数第一位是类型,倒数第二位是值)：0x%lx",intNumber,&intNumber,_objc_decodeTaggedPointer((__bridge const void * _Nullable)intNumber));
    NSLog(@"%@,%p，解码出来的值(倒数第一位是类型,倒数第二位是值)：0x%lx",floatNumber,&floatNumber,_objc_decodeTaggedPointer((__bridge const void * _Nullable)floatNumber));
    NSLog(@"%@,%p，解码出来的值(倒数第一位是类型,倒数第二位是值)：0x%lx",longNumber,&longNumber,_objc_decodeTaggedPointer((__bridge const void * _Nullable)longNumber));
    NSLog(@"%@,%p，解码出来的值(倒数第一位是类型,倒数第二位是值)：0x%lx",doubleNumber,&doubleNumber,_objc_decodeTaggedPointer((__bridge const void * _Nullable)doubleNumber));
}

/// 验证isa_t初始化方式（1.cls;2.bits）与+load方法是否开启有关，并查看64位存储内容
/// 使用objc源码构建可编译工程，然后在main中的[YLPerson alloc]断点 (注：YLPerson未开启+load方法) --> initInstanceIsa --> initIsa --> 走到else中的 isa初始化;
- (void)testIsa_init_Nonpointer {
    YLPerson *dog = [YLPerson alloc];
    NSLog(@"打印------");
}

/// 打印Nonpointer对象的引用计数 --> 一个巨大的数
- (void)test_retaincount_Nonpointer {
    NSNumber *num = [NSNumber numberWithInt:12];
    NSLog(@"NSNumber:12 的引用计数为 = %ld", (long)CFGetRetainCount((__bridge CFTypeRef)num));
}

- (void)test_retaincount_copy {
    YLPerson *dog = [[YLPerson alloc]init];
    YLPerson *dog1 = [dog copy];
    YLPerson *dog2 = [dog mutableCopy];
    NSLog(@"person:%p--person1:%p--person2:%p",dog,dog1,dog2);
}

/// 验证NSObject是否是唯一的
/// 使用x/4gx打印对象内存地址。逐级查询对象的isa指向，通过po查看其类型
- (void)testNSObject {
 
}

#pragma mark -lazy 数据源
- (NSString *)fileName {
    return @"memory_taggedpointer";
}

@end
