//
//  YLMsgSendViewController.m
//  YLNote
//
//  Created by tangh on 2021/7/29.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLMsgSendViewController.h"
#import <objc/runtime.h>
#import "YLOrganism.h"
#import "YLNoteData.h"


@implementation YLMsgSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/** iskindOfClass & isMemberOfClass
 isKindOfClass
 【+】类方法：元类（isa） --> 根元类（父类） --> 根类（父类） --> nil（父类） 与 传入类的对比
 【-】实例方法：对象的类 --> 父类 --> 根类 --> nil 与 传入类的对比

 isMemberOfClass ()
 【+】类方法： 类的元类 与 传入类 对比
 【-】实例方法：对象的类 与 传入类 对比

 */
- (void)testKindOrMember {
    //-----使用 iskindOfClass & isMemberOfClass 类方法
    BOOL re1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];       // (1.) NSObjecMeta(isa) == NSObject; ❎ (2.)NSObjecMeta.super == NSObject; ✅
    BOOL re2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];     //(1.) NSObjecMeta == NSObject; ❎
    BOOL re3 = [(id)[YLOrganism class] isKindOfClass:[YLOrganism class]];       // (1.) YLAnimaMeta(isa) == YLAnimal; ❎ (2.) NSObjecMeta(super) == YLAnimal; ❎ (3.) NSObject == YLAnimal; ❎ （4.）nil == YLAnimal; ❎
    BOOL re4 = [(id)[YLOrganism class] isMemberOfClass:[YLOrganism class]];     // (1.) YLAnimaMeta == YLAnimal; ❎
    NSLog(@"\n re1 :%hhd\n re2 :%hhd\n re3 :%hhd\n re4 :%hhd\n",re1,re2,re3,re4);

    //------iskindOfClass & isMemberOfClass 实例方法
    BOOL re5 = [(id)[NSObject alloc] isKindOfClass:[NSObject class]];       // ✅
    BOOL re6 = [(id)[NSObject alloc] isMemberOfClass:[NSObject class]];     // ✅
    BOOL re7 = [(id)[YLOrganism alloc] isKindOfClass:[YLOrganism class]];       // ✅
    BOOL re8 = [(id)[YLOrganism alloc] isMemberOfClass:[YLOrganism class]];     // ✅
    NSLog(@"\n re5 :%hhd\n re6 :%hhd\n re7 :%hhd\n re8 :%hhd\n",re5,re6,re7,re8);
}

/// 查找实例方法
/**底层方法实现：
 Class object_getClass(id obj)
 {
     if (obj) return obj->getIsa();
     else return Nil;
 }

 Class objc_getMetaClass(const char *aClassName)
 {
     Class cls;

     if (!aClassName) return Nil;

     cls = objc_getClass (aClassName);
     if (!cls)
     {
         _objc_inform ("class `%s' not linked into application", aClassName);
         return Nil;
     }

     return cls->ISA();
 }

 */
/** 实例对象-isa-->本类 ； 本类-isa-->元类 ； 元类-isa-->根元类 ； 根元类-isa-->自己 ;
     本类-super--super-...->NSObject-super->nil;
     元类-super(即父类的元类)--super-...->根元类；
     根元类-super-->NSObject;
 查找过程：（自身-->super链）
 method1：传入本类，先在本类中查找并找到；
 method2：传入元类，先在元类中查找，其次元类的super(NSObjectMeta)-->super(根类NSObject)-->super(nil);
 method3：传入本类，先在本类中查找，其次本类的super（NSObject）-->super(nil)；
 method3：传入元类，先在元类中查找，找到；
 */
- (void)testInstanceMethod {
    YLOrganism *animal = [YLOrganism alloc];
    Class oriClass = object_getClass(animal);

    const char *className = class_getName(oriClass);
    Class metaClass = objc_getMetaClass(className);

    Method method1 = class_getInstanceMethod(oriClass, @selector(sayHello));
    Method method2 = class_getInstanceMethod(metaClass, @selector(sayHello));

    Method method3 = class_getInstanceMethod(oriClass, @selector(sayHappy));
    Method method4 = class_getInstanceMethod(metaClass, @selector(sayHappy));
    NSLog(@"%s - %p-%p-%p-%p",__func__,method1,method2,method3,method4);
    
}

/// 查找类方法
/**
 查找过程：(自身类的元类-->super链)
 针对method4情况的解释：主要还是因为class_getClassMethod方法在元类的判断导致的，这是苹果人为制造的 递归终止条件，目的就是防止无限次递归;
 */
- (void)testClassMethod {
    YLOrganism *animal = [YLOrganism alloc];
    Class oriClass = object_getClass(animal);

    const char *className = class_getName(oriClass);
    Class metaClass = objc_getMetaClass(className);

    Method method1 = class_getClassMethod(oriClass, @selector(sayHello));
    Method method2 = class_getClassMethod(metaClass, @selector(sayHello));

    Method method3 = class_getClassMethod(oriClass, @selector(sayHappy)); // 查找过程：通过oriClass，找到其元类(getMeta()方法)，去元类中查找方法
    Method method4 = class_getClassMethod(metaClass, @selector(sayHappy)); // 📢注意：打印元类的类方法，是从自身上查找method；原因是底层getMeat()判断自身是meta，直接返回this
    NSLog(@"%s - %p-%p-%p-%p",__func__,method1,method2,method3,method4);
    
}

/// 方法的归属问题
/**
 打印结果：
 2021-07-29 02:48:45.448751+0800 YLNote[72969:5046907]
  0x100a1b180 // 找到IMP
  0x7fff20174440 // 消息转发：imp2 = 0x00007fff20174440 (libobjc.A.dylib`_objc_msgForward)
 Printing description of imp4:
  0x7fff20174440 // 同上
  0x100a1b1b0 // 找到imp

 */
- (void)testLookImpInClass_MeatClss {
    YLOrganism *animal = [YLOrganism alloc];
    Class oriClass = object_getClass(animal);
    NSLog(@"******* %s **********",__func__);

    const char *className = class_getName(oriClass);
    Class metaClass = objc_getMetaClass(className);

    // - (void)sayHello;
    // + (void)sayHappy;
    IMP imp1 = class_getMethodImplementation(oriClass, @selector(sayHello)); //
    IMP imp2 = class_getMethodImplementation(metaClass, @selector(sayHello));
    IMP imp3 = class_getMethodImplementation(oriClass, @selector(sayHappy));
    IMP imp4 = class_getMethodImplementation(metaClass, @selector(sayHappy));
    NSLog(@"\n %p\n %p\n %p\n %p",imp1,imp2,imp3,imp4);
    
}


- (NSString *)fileName {
    return @"runtime_msg_send";
}
@end
