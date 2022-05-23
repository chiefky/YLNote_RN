//
//  YLAnimal.m
//  YLNote
//
//  Created by tangh on 2021/7/29.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLAnimal.h"
@interface YLAnimal ()
@end

@implementation YLAnimal

/**
 测试方法
 */
+ (id)newTestObject {
    return [[YLAnimal alloc] init];
}

+ (id)allocTestObject {
    return [[YLAnimal alloc] init];
}

+ (id)testIdObject {
    return [[YLAnimal alloc] init];
}

+ (instancetype)testInstanceObject {
    return [YLAnimal alloc];
}


#pragma mark - 正式代码
+ (instancetype)animal {
    return [[[self class] alloc] initWithId:@"g000000" name:@"自定义生物"];
}

- (instancetype)initWithId:(NSString *)organismId name:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
        self.organismId = organismId;
    }
    
    return self;
}

- (void)sayHello{
    NSLog(@"YLAnimal say : Hello!!!");
}

+ (void)sayHappy{
    NSLog(@"YLAnimal say : Happy!!!");
}

- (void)sayA {
    NSLog(@"YLAnimal say : A!!!");
}
- (void)sayB {
    NSLog(@"YLAnimal say : B!!!");
}

#pragma mark - overwrite

- (YLDomain *)domain {
    return [[YLDomain alloc] initWithId:@"d_001" name:@"真核生物域"];
}

- (YLKindom *)kindom {
    return [[YLKindom alloc] initWithId:@"k_002" name:@"动物界"];
}


@end
