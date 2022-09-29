//
//  YLDog.m
//  YLNote
//
//  Created by tangh on 2021/7/27.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLDog.h"
#import <objc/runtime.h>

//@interface YLDog ()<NSCopying,NSMutableCopying>
//
//@end

@implementation YLDog

+ (void)load {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        SEL helloSel = @selector(sayHello);
        SEL wangwangSel = @selector(sayWangWang);
        
        Method helloMetod = class_getInstanceMethod([self class], helloSel);
        Method wangwangMethod = class_getInstanceMethod([self class], wangwangSel);
        method_exchangeImplementations(helloMetod, wangwangMethod);
        
    });
}

- (void)sayHello {
    NSLog(@"🐶：汪-汪-汪！");
}

- (void)sayWangWang {
    NSLog(@"🐶：HELLO!");
}

//- (void)printLog {
//    NSLog(@"%s",__FUNCTION__);
//}

//- (id)copyWithZone:(NSZone *)zone {
//    YLDog *dog = [[self class] allocWithZone:zone];
//    return dog;
//}
//
//- (id)mutableCopyWithZone:(NSZone *)zone {
//    YLDog *dog = [[self class] allocWithZone:zone];
//    return dog;
//}

@end
