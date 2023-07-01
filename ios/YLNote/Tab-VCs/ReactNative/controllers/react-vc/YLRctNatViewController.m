//
//  YLFlutterViewController.m
//  TestDemo
//
//  Created by tangh on 2020/7/19.
//  Copyright © 2020 tangh. All rights reserved.
//

#import "YLRctNatViewController.h"
#import "YLNoteBridgeAPI.h"
#import <React/RCTRootView.h>
#import <Masonry/Masonry.h>
#import "ReactHomeViewController.h"
#import <React/RCTBundleURLProvider.h>
@interface YLRctNatViewController ()
@property(nonatomic,strong)UIButton *home;
@end

@implementation YLRctNatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
        [self setupUI];
//[self initRCTRootView];
}

- (IBAction)highScoreButtonPressed:(id)sender {
    NSLog(@"High Score Button Pressed");
   

}
- (void)setupUI {
     self.home = [[UIButton alloc] init];
    self.home.backgroundColor = [UIColor orangeColor];
    [self.home addTarget:self action:@selector(homeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.home];
    [self.home setTitle:@"Home" forState:UIControlStateNormal];
    [self.home mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(98);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
}

- (void)homeAction:(UIButton *)sender {
    NSURL *jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackExtension:nil];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"RootScreen" initialProperties:nil launchOptions:nil];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - tests

@end
