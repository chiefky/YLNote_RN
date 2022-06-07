//
//  AppDelegate.m
//  TestDemo
//
//  Created by tangh on 2020/6/28.
//  Copyright © 2020 tangh. All rights reserved.
//

#import "AppDelegate.h"
#import <JSPatch/JPEngine.h>
#import "YLDefaultMacro.h"
#import "YLNotesViewController.h"
#import "YLGCDViewController.h"
#import "YLOCSwiftViewController.h"
#import "YLRctNatViewController.h"
#import "YLUserViewController.h"
#import "YLPerNoteViewController.h"
#import "YLNativeNewsViewController.h"
#import "YLNote-Swift.h"


/**
 * 设置图片
 */
NSString *kTabBarItemKeyImageName             = @"kTabBarItemKeyImageName";
/**
 * 设置选中图片
 */
NSString *kTabBarItemKeySelectedImageName     = @"kTabBarItemKeySelectedImageName";
/**
 * 设置文字颜色
 */
NSString *kTabBarItemKeyColorName             = @"kTabBarItemKeyColorName";
/**
 * 设置选中文字颜色
 */
NSString *kTabBarItemKeySelectedColorName     = @"kTabBarItemKeySelectedColorName";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[YLSkinMananger defaultManager] checkAndUpdateSkinSettingWithCompleteBlock:^(NSDictionary * _Nonnull dict) {
//        NSLog(@"******+++= %@",dict);
    }];

    [self appearanceSetting];

//    NSLog(@"%s",__func__);
    self.window = [[UIWindow alloc] initWithFrame: YLSCREEN_BOUNDS];
    
    YLPerNoteViewController *noteVC = [[YLPerNoteViewController alloc] init];
    noteVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"笔记" image:[UIImage imageNamed:@"note"] tag:4];
    UINavigationController *naviNote = [[UINavigationController alloc] initWithRootViewController:noteVC];

    YLAlgoViewController *algoriVC = [[YLAlgoViewController alloc] init];
    algoriVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"算法" image:[UIImage imageNamed:@"algorithm"] tag:2];
    UINavigationController *naviAlgori = [[UINavigationController alloc] initWithRootViewController:algoriVC];

    
    YLSwiftViewController *swiftVC = [[YLSwiftViewController alloc] init];
    swiftVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Swift" image:[UIImage imageNamed:@"swift"] tag:3];
    UINavigationController *naviSwift = [[UINavigationController alloc] initWithRootViewController:swiftVC];

    YLRctNatViewController *flutterVC = [[YLRctNatViewController alloc] init];
    flutterVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"ReactNative" image:[UIImage imageNamed:@"react"] tag:4];
    
    YLNativeNewsViewController *homeVC = [[YLNativeNewsViewController alloc] initWithNibName:@"YLNativeNewsViewController" bundle:nil];
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Native" image:[UIImage imageNamed:@"flutter"] tag:5];
    UINavigationController *naviUser = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
     UITabBarController *tab = [[UITabBarController alloc] init];
    tab.tabBar.translucent = NO;
     tab.viewControllers = @[naviNote,naviAlgori,naviSwift,flutterVC,naviUser];
    self.window.rootViewController = tab;
     [self.window makeKeyAndVisible];
     
    return YES;
}

/// <#Description#>
- (void)appearanceSetting {
    [UITabBar appearance].barTintColor = [YLTheme main].tabTintColor;
    [UITabBar appearance].tintColor = [YLTheme main].themeColor;
    [UINavigationBar appearance].barTintColor = [YLTheme main].themeColor ;
    [UINavigationBar appearance].tintColor = [YLTheme main].naviTintColor;
    [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName:[YLTheme main].mainFont,NSForegroundColorAttributeName:[YLTheme main].backColor};
    // 抹去navigationbar 返回按钮title (推荐)
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];

}

- (void)checkOrWritePlist:(void(^)(NSDictionary *))completeBlock {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Skin" ofType:@"plist"];
    NSMutableDictionary * mutDic = [NSMutableDictionary dictionary];

    if (path == nil) {
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] ;
        NSString *infoFilePath = [cachesPath stringByAppendingPathComponent:@"Skin.plist"];
        
        [mutDic setValue:@{@"color":@"DC143C"} forKey:@"red"];
        [mutDic setValue:@{@"color":@"FF00F0"} forKey:@"blue"];
        [mutDic setValue:@{@"color":@"fd9c2e"} forKey:@"yellow"];
        [mutDic setValue:@"blue" forKey:@"selectColor"];
        [mutDic setValue:@"yellow" forKey:@"tintColor"];

        [mutDic writeToFile:infoFilePath atomically:YES];
    }
    if (completeBlock) {
        completeBlock([mutDic copy]);
    }
}
- (void)rctConfig {
    
}
@end
