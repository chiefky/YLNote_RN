//
//  YLSwift_in_OCViewController.m
//  YLNote
//
//  Created by tangh on 2022/7/19.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLSwift_in_OCViewController.h"
#import "YLNote-Swift.h"

/**
 在OC中使用Swift
 */
@interface YLSwift_in_OCViewController ()
@property (nonatomic,strong) PinkPigSwiftSon *son;

@end

@implementation YLSwift_in_OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"在OC中使用Swift";

    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self testSwiftClass];
    [self testDifferenceSiwft_OCPro];
    [self testDynamicKeyWord];
}

- (void)testSwiftClass {
    //    继承自NSObject的swift类
    PinkPigSwift *pig = [[PinkPigSwift alloc] init];
    [pig sayHello];

    if ([pig respondsToSelector:@selector(showCard)]) {
        [pig performSelector:@selector(showCard)];
    } else {
        NSLog(@"`showCard` is not called!");
    }
    PinkPigSwiftSon *pigson = [[PinkPigSwiftSon alloc] init];
    [pigson sayHello];
}

/// 跟在swift controller中结果一致
- (void)testDifferenceSiwft_OCPro {
    NSLog(@"*************🐷 所有属性：");
    [self printPropertyNameforClass:[PinkPigOC class]];
    [self printPropertyNameforClass:[PinkPigSwift class]];
    [self printPropertyNameforClass:[PinkPigSwiftSon class]];
    NSLog(@"*************🐷.");
}

/// 在OC类中使用swift类，无论加不加dynamic关键字都能完美使用运行时
- (void)testDynamicKeyWord {
    self.son = [[PinkPigSwiftSon alloc] init];
    [self.son addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.son addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.son addObserver:self forKeyPath:@"clothes" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    self.son.name = @"唐PP";
    self.son.age = 5;
    self.son.clothes = @"🧦";
    [self.son introduction];
}

- (void)printPropertyNameforClass:(id)class {
    NSMutableString *allPro = [NSMutableString stringWithFormat:@"%@: ",class];
    /** 记录属性个数 */
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(class, &outCount);
    
    /** 遍历所有属性 */
    for (unsigned int i = 0; i<outCount; i++) {
        objc_property_t property = properties[i];
        char punctuation = i == outCount - 1 ? '.' : ',' ;
        [allPro appendFormat:@"%s%c ",property_getName(property),punctuation];
    }
    
    NSLog(@"%@",allPro);

    /** 释放内存 */
    free(properties);

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    NSLog(@"KVO %@: old %@ ",keyPath,change[@"old"]);
    NSLog(@"KVO %@: new %@",keyPath,change[@"new"]);
}

- (void)dealloc
{
    [self.son removeObserver:self forKeyPath:@"name"];
    [self.son removeObserver:self forKeyPath:@"age"];
    [self.son removeObserver:self forKeyPath:@"clothes"];

}

@end
