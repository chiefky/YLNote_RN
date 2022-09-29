//
//  YLKVCViewController.m
//  YLNote
//
//  Created by tangh on 2021/12/7.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLKVCViewController.h"
#import "YLKVCPerson.h"
#import "YLKVCUsageViewController.h"

@interface YLKVCViewController ()

@end

@implementation YLKVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)testMyKVC {
    YLKVCPerson *person = [[YLKVCPerson alloc] init];
//    [person printAllVars];
    [person setMyValue:@"张三" forKey:@"name"];
    [person setMyValue:@"男" forKey:@"gender"];
    [person setMyValue:@"北京市" forKey:@"address"];
    [person setMyValue:@"10010" forKey:@"tel"];

    NSLog(@"我叫 %@, %@,%@,%@",[person myValueforKey:@"name"],[person myValueforKey:@"gender"],[person myValueforKey:@"address"],[person myValueforKey:@"tel"]);
}

/// 用途
- (void)testShowUsage {
    YLKVCUsageViewController *usage = [[YLKVCUsageViewController alloc] init];
    [self.navigationController pushViewController:usage animated:YES];
}

#pragma mark - cell data
- (NSString *)fileName {
    return @"kvc";
}

@end
