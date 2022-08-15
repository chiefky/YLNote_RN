//
//  YLProxy.m
//  YLNote
//
//  Created by tangh on 2021/7/26.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLProxy.h"
#import "YLCrashHandler.h"

/**
 四、 NSProxy 和 NSObject 的比较

 使用 NSProxy 做消息转发 比 使用 NSObject 效率高。
 当这两个类都没有执行消息转发时，会报什么样的错误？

 NSProxy 会直接报 methodSignatureForSelector 方法错误
 NSObject 会报 [NSObject timerTest] 没有找到 错误
 他们两个的执行流程：

 继承至 NSObject 的类：
 先去类对象里面找 -> 父类的类对象找 -> 缓存中 -> 搜索
 继承至 NSProxy 的类：
 先会在本类中找，如果没有直接消息转发。不会去 类对象找，父类的类对象中找。
 ————————————————
 版权声明：本文为CSDN博主「M316625387」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
 原文链接：https://blog.csdn.net/M316625387/article/details/84284997
 */

@implementation YLProxy

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target {
    return [[self alloc] initWithTarget:target];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [self.target respondsToSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    if (self.target && [self.target respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:self.target];
        return;
    } else {
        YLCrashHandler *crashHandler = [[YLCrashHandler alloc] init];
        SEL handlerSel = @selector(msgTransformErrorWtihOrigin:originSEL:);
        if ([crashHandler respondsToSelector:handlerSel]) {
            // 方法一：使用原invocation -->anInvocation
            [anInvocation setSelector:handlerSel];
            NSString *className = NSStringFromClass([self.target class]) ?: @"nil";
            [anInvocation setArgument:&className atIndex:2];
            [anInvocation setArgument:&selector atIndex:3];
            [anInvocation invokeWithTarget:crashHandler];

            // 方法二：使用新的invocation
            /*
            //获取方法签名
            NSMethodSignature *signature = [crashHandler methodSignatureForSelector:handlerSel];
            //获取方法签名对应的invocation
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setSelector:handlerSel];

            //设置参数
            NSString *className = NSStringFromClass([self.realTarget class]) ?: @"nil";
            [invocation setArgument:&className atIndex:2];
            [invocation setArgument:&selector atIndex:3];
            //开始执行
            [invocation invokeWithTarget:crashHandler];
             */
        }

    }
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    // 🍅 NSMethodSignature获取方法：a;b;c;
    //    a. [[self.realTarget class] instanceMethodForSelector:aSelector];
    //    b. [self.realTarget methodSignatureForSelector:aSelector];
    //    c. [NSMethodSignature signatureWithObjCTypes:"v@:"]; // 使用类型编码（官方手册地址：https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100）

    if (self.target && [self.target respondsToSelector:aSelector]) {
        // 转移至目标对象
        return [self.target methodSignatureForSelector:aSelector];
    } else {
        // 转移至crash收集对象的方法签名 (self.realTarget == nil 或 self.realTarget找不到aSelector)
        // NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:@:"];
        SEL handlerSel = @selector(msgTransformErrorWtihOrigin:originSEL:);
        YLCrashHandler *handler = [YLCrashHandler new];
        return [handler methodSignatureForSelector:handlerSel];
    }
}

@end
