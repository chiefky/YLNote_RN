//
//  YLRuntimeMsgFwd1TableController.m
//  YLNote
//
//  Created by tangh on 2021/7/27.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLRuntimeMsgFwd1TableController.h"
#import <objc/runtime.h>
#import "YLTarget.h"
#import "YLDog.h"
#import "YLNoteData.h"


extern void instrumentObjcMessageSends(BOOL flag);


@interface YLRuntimeMsgFwd1TableController ()

@property(nonatomic,strong) NSTimer *targetTimer;
@property(nonatomic,strong) YLTarget *tmpTarget;

@end

@implementation YLRuntimeMsgFwd1TableController

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - demos
- (void)testMsgForward {
    YLDog *dog = [[YLDog alloc] init];
    self.tmpTarget = [YLTarget targetWithRealTarget:dog];
    [self.tmpTarget performSelector:@selector(printLog)];
    
//    instrumentObjcMessageSends(YES);
//    [dog printLog];
//    instrumentObjcMessageSends(NO);

}

- (void)testMethodSwizzing {
    YLDog *dog = [YLDog new];
    [dog sayWangWang];
}

// 类族
- (void)testIsaDict {
    NSDictionary *dic = [NSDictionary dictionary];
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];

    //输出1
    Class dic_super = class_getSuperclass([dic class]);

    Class dic_Isa = object_getClass(dic);
    Class dic_Isa_super = class_getSuperclass(dic_Isa);

    Class dic_Isa_Isa = object_getClass(dic_Isa);
    Class dic_Isa_Isa_super = class_getSuperclass(dic_Isa_Isa);

    Class dic_Isa_Isa_Isa = object_getClass(dic_Isa_Isa);
    Class dic_Isa_Isa_Isa_super = class_getSuperclass(dic_Isa_Isa_Isa);

    
    Class dicmIsa = object_getClass(dicM);
    NSLog(@"%@", dicmIsa);
}


#pragma mark - lazy
- (NSString *)fileName {
    return @"runtime_msg_trans1";
}
@end

