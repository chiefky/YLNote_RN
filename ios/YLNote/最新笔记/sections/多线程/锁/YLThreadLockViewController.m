//
//  YLThreadLockViewController.m
//  YLNote
//
//  Created by tangh on 2022/3/1.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLThreadLockViewController.h"

@interface YLThreadLockViewController ()

@end

@implementation YLThreadLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -overrid
- (NSString *)fileName {
    return @"thread_lock";
}
@end
