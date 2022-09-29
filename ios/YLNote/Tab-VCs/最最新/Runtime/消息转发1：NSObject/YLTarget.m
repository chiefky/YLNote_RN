//
//  YLTarget.m
//  YLNote
//
//  Created by tangh on 2021/7/26.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLTarget.h"
#import <objc/runtime.h>
#import "YLCrashHandler.h"

void run(id self, SEL _cmd) {
    NSLog(@"动态绑定run方法：%@ -- %s", self, sel_getName(_cmd));
}

@implementation YLTarget

- (instancetype)initWithRealTarget:(id)realTarget {
    _realTarget = realTarget;
    return self;
}

+ (instancetype)targetWithRealTarget:(id)realTarget {
    return [[self alloc] initWithRealTarget:realTarget];
}

#pragma mark - 第一步：动态方法决议(给当前对象增加方法实现，不改变接收消息对象)
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"%s---%@",__FUNCTION__,NSStringFromSelector(sel));
    if (sel == @selector(doAction)) {
        return class_addMethod(self, sel, (IMP)run, "v@:");
    }

    return [super resolveInstanceMethod:sel];
}

#pragma mark - 第二步：快速转发（转发给一个可以响应的方法对象，改变接收消息对象）
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"%s---%@",__FUNCTION__,NSStringFromSelector(aSelector));

//    if (self.realTarget && [self.realTarget respondsToSelector:aSelector]) {
//        return self.realTarget;
//    }
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark - 第二步：慢速转发（构建一个invacation，可自定义selector，或者改变参数==；改变接收消息对象）

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%s---%@",__FUNCTION__,NSStringFromSelector(anInvocation.selector));
    SEL selector = [anInvocation selector];
    if (self.realTarget && [self.realTarget respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:self.realTarget];
        return;
    } else {
        YLCrashHandler *crashHandler = [[YLCrashHandler alloc] init];
        SEL handlerSel = @selector(msgTransformErrorWtihOrigin:originSEL:);
        if ([crashHandler respondsToSelector:handlerSel]) {
            // 方法一：使用原invocation -->anInvocation
            [anInvocation setSelector:handlerSel];
            NSString *className = NSStringFromClass([self.realTarget class]) ?: @"nil";
            [anInvocation setArgument:&className atIndex:2];
            [anInvocation setArgument:&selector atIndex:3];
            [anInvocation invokeWithTarget:crashHandler];

            // 方法二：使用新的invocation
            /**
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
    NSLog(@"%s---%@",__FUNCTION__,NSStringFromSelector(aSelector));

    // 🍅 NSMethodSignature获取方法：a;b;c;
    //    a. [[self.realTarget class] instanceMethodForSelector:aSelector];
    //    b. [self.realTarget methodSignatureForSelector:aSelector];
    //    c. [NSMethodSignature signatureWithObjCTypes:"v@:"]; // 使用类型编码（官方手册地址：https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100）

    if (self.realTarget && [self.realTarget respondsToSelector:aSelector]) {
        // 转移至目标对象
        return [self.realTarget methodSignatureForSelector:aSelector];
    } else {
        // 转移至crash收集对象的方法签名 (self.realTarget == nil 或 self.realTarget找不到aSelector)
        // NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:@:"];
        SEL handlerSel = @selector(msgTransformErrorWtihOrigin:originSEL:);
        YLCrashHandler *handler = [YLCrashHandler new];
        return [handler methodSignatureForSelector:handlerSel];
    }
}

@end
