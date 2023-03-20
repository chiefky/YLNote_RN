//
//  YLNotificationViewController.m
//  YLNote
//
//  Created by tangh on 2023/2/1.
//  Copyright © 2023 tangh. All rights reserved.
//

#import "YLNotificationViewController.h"
#import "YLNote-Swift.h"
static NSString *kYLNotificationChangeColor = @"kYLNotificationChangeColor";

@interface YLNotificationViewController ()

@end

@implementation YLNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
//        [self addNotificationObserver];
//        [self addNotificationObserver];
        [self addNotificationObserver];
    });
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addNotificationObserver {
    NSLog(@"%s：%@",__FUNCTION__,[NSThread currentThread]);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:kYLNotificationChangeColor object:nil];
}

- (void)changeColor:(id)sender {
    self.table.backgroundColor = [UIColor random];
    NSLog(@"随机色值：%@",[UIColor random]);
    if (sender) {
        NSNotification *send = sender;
        NSLog(@"");
    }
    NSLog(@"%s：%@",__FUNCTION__,[NSThread currentThread]);
}

#pragma mark - actions
- (void)testNotification_0 {
    NSLog(@"%s：%@",__FUNCTION__,[NSThread currentThread]);
    [[NSNotificationCenter defaultCenter] postNotificationName:kYLNotificationChangeColor object:self userInfo:@{@"name":@"red"}];
}


- (NSString *)fileName {
    return @"notification";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
