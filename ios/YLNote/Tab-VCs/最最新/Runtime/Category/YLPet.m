//
//  YLPet.m
//  YLNote
//
//  Created by tangh on 2021/7/15.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLPet.h"
#import <objc/runtime.h>
//static NSArray *array;
static NSString *_name;

@implementation YLPet

@end

@implementation YLPet (Language)

- (void)setName:(NSString *)name {
    if (![_name isEqualToString:name]) {
        _name = [name copy];
    }
}

- (NSString *)name {
    return _name;
}

#pragma mark - 实现关联属性
- (void)setLanguages:(NSArray *)languages {
    objc_setAssociatedObject(self, @selector(languages), languages, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSArray *)languages {
    return objc_getAssociatedObject(self, _cmd);
}

@end
