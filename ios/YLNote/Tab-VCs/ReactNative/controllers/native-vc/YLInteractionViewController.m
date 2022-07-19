//
//  YLInteractionViewController.m
//  YLNote
//
//  Created by tangh on 2022/6/8.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLInteractionViewController.h"
#import <React/RCTRootView.h>
#import <Masonry/Masonry.h>
#import "YLNoteBridgeAPI.h"
#import "YLRNTEventManager.h"

@interface YLInteractionViewController ()

@end

@implementation YLInteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupUI];
}

- (void)setupUI {
    
    RCTRootView *rootView = [[RCTRootView alloc]initWithBridge:[YLNoteBridgeAPI shareInstance] moduleName:@"Interaction" initialProperties:  @{@"XXX":@""}];
    [self.view addSubview:rootView];
    [rootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-80);
    }];
    UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
    [test setTitle:@"Native控件" forState:UIControlStateNormal];
    [test setBackgroundColor:[UIColor orangeColor]];
    [test addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
    [test mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rootView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(45);
    }];

}

- (void)testAction:(UIButton *)sender {
    NSDictionary *dict = @{@"mmm": @""};
    [YLRNTEventManager postEventWithName:@"selectItem" parameter:dict];
}

@end
