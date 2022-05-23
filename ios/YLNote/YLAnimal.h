//
//  YLAnimal.h
//  YLNote
//
//  Created by tangh on 2021/7/29.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLOrganism.h"

typedef uint32_t mask_t;  // x86_64 & arm64 asm are less efficient with 16-bits

struct yl_bucket_t {
    SEL _sel;
    IMP _imp;
};

struct yl_cache_t {
    struct yl_bucket_t * _buckets;
    mask_t _mask;
    uint16_t _flags;
    uint16_t _occupied;
};

struct yl_class_data_bits_t {
    uintptr_t bits;
};

struct yl_objc_class {
    Class ISA;
    Class superclass;
    struct yl_cache_t cache;             // formerly cache pointer and vtable
    struct yl_class_data_bits_t bits;    // class_rw_t * plus custom rr/alloc flags
};


NS_ASSUME_NONNULL_BEGIN

@interface YLAnimal : YLOrganism

/**
 测试代码，非真正可使构造方法
 */
+ (id)newTestObject;  // 返回一个自动关联为YLAnimal类型的对象
+ (id)allocTestObject;// 返回一个自动关联为YLAnimal类型的对象
+ (id)testIdObject;// 返回一个类型不明的对象
+ (instancetype)testInstanceObject;// 返回一个自动关联为YLAnimal类型的对象


/// 构造方法
+ (instancetype)animal;

- (void)sayHello;
+ (void)sayHappy;
- (void)sayA;
- (void)sayB;

@end

NS_ASSUME_NONNULL_END
