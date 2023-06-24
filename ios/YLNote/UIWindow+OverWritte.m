//
//  UIWindow+OverWritte.m
//  YLNote
//
//  Created by tangh on 2023/3/28.
//  Copyright © 2023 tangh. All rights reserved.
//

#import "UIWindow+OverWritte.h"
#import "objc/runtime.h"
@implementation UIWindow (OverWritte)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        SEL originSEL = @selector(sendEvent:);
//        SEL swizzledSEL = @selector(yl_sendEvent:);
//
//        IMP originIMP = class_getMethodImplementation(self,originSEL);
//        IMP swizzledIMP = class_getMethodImplementation(self, swizzledSEL);
//
//        Method oriMethod = class_getInstanceMethod(self, originSEL);
//        Method swiMethod = class_getInstanceMethod(self, swizzledSEL);
//
//        BOOL addSuccess = class_addMethod(self, originSEL, swizzledIMP, method_getTypeEncoding(oriMethod));
//        if (addSuccess) {
//            // 说明自己没有原始实现，把原始方法实现替换给swizzeld
//            class_replaceMethod(self, swizzledSEL, originIMP, method_getTypeEncoding(oriMethod));
//        } else {
//            // 有 直接交换
//            method_exchangeImplementations(oriMethod, swiMethod);
//        }
//    });
//
//}

- (void)yl_sendEvent:(UIEvent *)event {
    NSLog(@"%s:%@,",__FUNCTION__,event);
    [self yl_sendEvent:event];
}

@end
