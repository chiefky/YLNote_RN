//
//  YLMemoryAlignViewController.m
//  YLNote
//
//  Created by tangh on 2021/8/12.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLMemoryAlignViewController.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

#import "YLOrganism.h"
#import "YLAnimal.h"
#import "YLNoteData.h"

struct Struct1 {
    double a; // 8
    int b; // 4
    char c; // 1
    short d; // 2
} ylStruct1; // 对齐后16字节

struct Struct2 {
    int a; // 4
    double b; // 8
    int c; // 4
    char d; // 1
} ylStruct2; // 对齐后 24字节

struct Struct3{
    char a;   //1字节
    int b;      //4字节
    short c;    //2字节
    double d;     //8字节
    struct Struct2 str;
} ylStruct3;// 对齐后 48字节


@interface YLMemoryAlignViewController ()

@end

@implementation YLMemoryAlignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)testAlignSizeOf {
    NSLog(@"%lu-%lu",sizeof(ylStruct1),sizeof(ylStruct2));
    NSLog(@"Struct3中结构体成员内存大小：%lu-%lu", sizeof(ylStruct3),sizeof(ylStruct3.str));
//    NSLog(@"系统分配空间大小:%lu",malloc_size(&Struct1));
    struct Struct1 *cptStruct = &ylStruct1;// (__bridge struct Computer_IMPL *)(cpt);
    cptStruct->a = 9.2;
    cptStruct->b = 2;
    NSLog(@"cptStruct->a: %f, cptStruct->b: %d", cptStruct->a, cptStruct->b);


}

- (void)testDiff_MemorySize {
    NSObject *obj = [[NSObject alloc] init]; // 根类
    YLOrganism *organism = [YLOrganism new]; // 父类
    YLAnimal *animal = [YLAnimal new]; // 子类
    NSLog(@"对象（指针）类型占用大小：[obj,organism,animal]：[%lu,%lu,%lu]",sizeof(obj),sizeof(organism),sizeof(animal));
    NSLog(@"对象实际占用空间大小：[obj,organism,animal]：[%lu,%lu,%lu]",class_getInstanceSize([obj class]),class_getInstanceSize([organism class]),class_getInstanceSize([animal class]));
    NSLog(@"系统分配空间大小：[obj,organism,animal]：[%lu,%lu,%lu]",malloc_size((__bridge const void*)(obj)),malloc_size((__bridge const void*)(organism)),malloc_size((__bridge const void*)(animal)));
}

#pragma mark -lazy
- (NSString *)fileName {
    return @"memory_align";
}

@end
