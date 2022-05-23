//
//  YLOptimizeStartViewController.m
//  YLNote
//
//  Created by tangh on 2022/3/20.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLOptimizeStartViewController.h"
#import "YLObject.h"
#import "YLDomain.h"
#import "YLKindom.h"

@interface YLOptimizeStartViewController ()

@end

@implementation YLOptimizeStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -
- (void)test_initialize {
//    YLObject *obj1 = [[YLObject alloc] init];
//    YLObject *obj2 = [YLObject new];
//    YLObject *obj3 = [YLObject new];
//    YLDomain *domain = [YLDomain new];
//    NSLog(@"---------------------");
    YLKindom *kindom = [YLKindom new];

}

#pragma mark - Navigation
- (NSString *)fileName {
    return @"optimize_start";
}


@end
