//
//  YLRuntimeWeakViewController.m
//  YLNote
//
//  Created by tangh on 2021/7/12.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLRuntimeWeakViewController.h"
@interface YLRuntimeWeakViewController ()

@end

@implementation YLRuntimeWeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSObject *object = [NSObject alloc];
    id __weak objc = object;

}


@end
