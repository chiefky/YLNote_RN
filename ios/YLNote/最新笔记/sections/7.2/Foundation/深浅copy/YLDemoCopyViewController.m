//
//  YLDemoCopyViewController.m
//  YLNote
//
//  Created by tangh on 2021/7/2.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLDemoCopyViewController.h"

@interface YLDemoCopyViewController ()

@property (nonatomic,strong) NSString *strStrong;
@property (nonatomic,copy) NSString *strCopy;

@end

@implementation YLDemoCopyViewController

/// <#Description#>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 属性修饰符strong测试
    [self testProStrongString]; // 赋值不可变字符串
    [self testProStrongMutableString]; // 赋值可变字符串
    
    // 属性修饰符copy测试
    [self testProCopyMutableString]; // 赋值可变字符串;赋值不可变字符串(略)
    
    // 深浅copy测试
    [self testCopyString];
    [self testMCopyString];
    [self testCopyMString];
    [self testMCopyMString];
}


#pragma mark - 属性内存管理语义（strong or copy）
- (void)testProStrongString {
    NSLog(@"******* strong赋值不可变对象 start **********");

    NSString *tmpString = @"Hello World";
    self.strStrong = tmpString;
    NSLog(@"%p = tmpString 的内存地址",tmpString);
    NSLog(@"%p = self.strStrong内存地址",self.strStrong);
    tmpString = @"哈哈哈哈";
    NSLog(@"%p = tmpString 的内存地址",tmpString);
    NSLog(@"%p = self.strStrong内存地址",self.strStrong);
    NSLog(@"******* strong赋值不可变对象 end **********\n");

}

- (void)testProStrongMutableString {
    NSLog(@"******* strong赋值可变对象 start **********");
    NSMutableString *tmpString = [NSMutableString stringWithString:@"Hello World"];
    self.strStrong = tmpString;
    NSLog(@"%p = tmpString 的内存地址",tmpString);
    NSLog(@"%p = self.strStrong内存地址",self.strStrong);
    [tmpString appendString:@"😄"];
    NSLog(@"%p = tmpString 的内存地址",tmpString);
    NSLog(@"%p = self.strStrong内存地址",self.strStrong);
    NSLog(@"******* strong赋值可变对象 end **********\n");

}

- (void)testProCopyMutableString {
   NSLog(@"******* copy 赋值可变对象 start **********");
   NSMutableString *tmpString = [NSMutableString stringWithString:@"Hello World"];
   self.strCopy = tmpString;
   NSLog(@"%p = tmpString 的内存地址",tmpString);
   NSLog(@"%p = self.strCopy内存地址",self.strCopy);
   [tmpString appendString:@"😄"];
   NSLog(@"%p = tmpString 的内存地址",tmpString);
   NSLog(@"%p = self.strCopy内存地址",self.strCopy);
   NSLog(@"******* copy 赋值可变对象 end **********\n");

}



#pragma mark - 深浅copy test
- (void)testCopyString {
    NSString *A = @"aaa";
    id C = [A copy];
    NSLog(@"******* copy不可变对象 start **********");
    NSLog(@"%p = 原对象指针地址",&A);
    NSLog(@"%p = copy的对象指针地址",&C);
    NSLog(@"%p = 原对象的内存地址",A);
    NSLog(@"%p = copy的对象的内存地址",C);
    NSLog(@"******* copy不可变对象 end **********\n");
}

- (void)testMCopyString {
    NSString *A = @"aaa";
    id C = [A mutableCopy];
    NSLog(@"******* mutableCopy不可变对象 start **********");
    NSLog(@"%p = 原对象指针地址",&A);
    NSLog(@"%p = mutableCopy的对象指针地址",&C);
    NSLog(@"%p = 原对象的内存地址",A);
    NSLog(@"%p = mutableCopy的对象的内存地址",C);
    NSLog(@"******* mutableCopy不可变对象 end **********\n");

}

- (void)testCopyMString {
    NSMutableString *B = [NSMutableString stringWithString:@"bbb"];
    id C = [B copy];
    NSLog(@"******* copy可变对象 start **********");
    NSLog(@"%p = 原对象指针地址",&B);
    NSLog(@"%p = copy的对象指针地址",&C);
    NSLog(@"%p = 原对象的内存地址",B);
    NSLog(@"%p = copy的对象的内存地址",C);
    NSLog(@"******* copy可变对象 end **********\n");

}

- (void)testMCopyMString {
    NSMutableString *B = [NSMutableString stringWithString:@"bbb"];
    id C = [B mutableCopy];
    NSLog(@"******* mutableCopy不可变对象 start **********");
    NSLog(@"%p = 原对象指针地址",&B);
    NSLog(@"%p = mutableCopy的对象指针地址",&C);
    NSLog(@"%p = 原对象的内存地址",B);
    NSLog(@"%p = mutableCopy的对象的内存地址",C);
    NSLog(@"******* mutableCopy不可变对象 end **********\n");

}



@end
