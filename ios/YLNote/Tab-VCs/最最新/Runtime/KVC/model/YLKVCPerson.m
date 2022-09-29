//
//  YLKVCPerson.m
//  YLNote
//
//  Created by tangh on 2021/12/7.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLKVCPerson.h"
#import <objc/runtime.h>

@interface YLKVCPerson ()
{
    NSString *_name;
    NSString *_isGender;
    NSString *address;
    NSString *isTel;

}

@end

@implementation YLKVCPerson

- (void)printAllVars {
    unsigned int a;

    objc_property_t * result = class_copyPropertyList(object_getClass(self), &a);

    for (unsigned int i = 0; i < a; i++) {
        objc_property_t o_t =  result[i];
        NSLog(@"%@", [NSString stringWithFormat:@"%s", property_getName(o_t)]);
    }

    free(result);

    Ivar * iv = class_copyIvarList(object_getClass(self), &a);
    for (unsigned int i = 0; i < a; i++) {
        Ivar i_v = iv[i];
        NSLog(@"%@", [NSString stringWithFormat:@"%s", ivar_getName(i_v)]);
    }
    free(iv);
}

- (void)setMyValue:(id)value forKey:(NSString *)key{
    if (key == nil || key.length == 0) {  //key名要合法
        return;
    }
    if ([value isKindOfClass:[NSNull class]]) {
        [self setNilValueForKey:key]; //如果需要完全自定义，那么这里需要写一个setMyNilValueForKey，但是必要性不是很大，就省略了
        return;
    }
    if (![value isKindOfClass:[NSObject class]]) {
        @throw @"must be s NSObject type";
        return;
    }

    NSString* funcName = [NSString stringWithFormat:@"set%@:",key.capitalizedString];
    if ([self respondsToSelector:NSSelectorFromString(funcName)]) {  //默认优先调用set方法
        SEL selName = NSSelectorFromString(funcName);
        [self performSelector:selName withObject:value];
        return;
    }
    unsigned int count;
    BOOL flag = false;
    Ivar* vars = class_copyIvarList([self class], &count);
    for (NSInteger i = 0; i<count; i++) {
        Ivar var = vars[i];
        NSString* keyName = [NSString stringWithFormat:@"%s", ivar_getName(var)];
        
        NSMutableString* isKey = [NSMutableString stringWithFormat:@"%@", [@"is" stringByAppendingString:key]];

        char c = [key characterAtIndex:0];
        [isKey replaceCharactersInRange:NSMakeRange(2, 1) withString:[[NSString stringWithFormat:@"%c",c] uppercaseString]];

        if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@",key]]) {
            flag = true;
            object_setIvar(self, var, value);
            NSLog(@"%@ 匹配 _<key>",keyName);
            break;
        }

        if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@",isKey]]) {
            flag = true;
            object_setIvar(self, var, value);
            NSLog(@"%@ 匹配 _is<key>",keyName);
            break;
        }
        
        if ([keyName isEqualToString:key]) {
            flag = true;
            object_setIvar(self, var, value);
            NSLog(@"%@ 匹配 <key>",keyName);
            break;
        }
        
        
        if ([keyName isEqualToString:isKey]) {
            flag = true;
            object_setIvar(self, var, value);
            NSLog(@"%@ 匹配  is<key>",keyName);
            break;
        }
        

    }
    if (!flag) {
        [self setMyValue:value forUndefinedKey:key];
    }
}

- (id)myValueforKey:(NSString *)key{
    if (key == nil || key.length == 0) {
        return [NSNull new]; //其实不能这么写的
    }
    //这里为了更方便，我就不做相关集合的方法查询了
//    NSString* funcName = [NSString stringWithFormat:@"get%@:",key.capitalizedString];
//    if ([self respondsToSelector:NSSelectorFromString(funcName)]) {
//       return [self performSelector:NSSelectorFromString(funcName)];
//    }

    unsigned int count;
    BOOL flag = false;
    Ivar* vars = class_copyIvarList([self class], &count);
    for (NSInteger i = 0; i<count; i++) {
        Ivar var = vars[i];
        NSString* keyName = [NSString stringWithCString:ivar_getName(var) encoding:NSUTF8StringEncoding];
        NSMutableString* isKey = [NSMutableString stringWithFormat:@"is%@", key.capitalizedString];

        if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@",key]]) {
            flag = true;
            return     object_getIvar(self, var);
            break;
        }
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@",key]]) {
            flag = true;
            return     object_getIvar(self, var);
            break;
        }

        if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@",key]]) {
            flag = true;
            return     object_getIvar(self, var);
            break;
        }
        if ([keyName isEqualToString:key]) {
            flag = true;
            return     object_getIvar(self, var);
            break;
        }
    }
    if (!flag) {
        [self myValueforKey:key];
    }
   return [NSNull new]; //其实不能这么写的
}


- (void)setMyValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%s 抛出异常：[%@] 未定义",__func__,key);
}

- (id)myValueForUndefinedKey:(NSString *)key {
    NSLog(@"%s 抛出异常：[%@] 未定义",__func__,key);
    return [NSNull new]; //其实不能这么写的
}

@end
