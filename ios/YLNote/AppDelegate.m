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
    algoriVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"算法整理" image:[UIImage imageNamed:@"algorithm"] tag:2];
    UINavigationController *naviAlgori = [[UINavigationController alloc] initWithRootViewController:algoriVC];
    
    
    YLSwiftViewController *swiftVC = [[YLSwiftViewController alloc] init];
    swiftVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Swift" image:[UIImage imageNamed:@"swift"] tag:3];
    UINavigationController *naviSwift = [[UINavigationController alloc] initWithRootViewController:swiftVC];
    
    YLRctNatViewController *flutterVC = [[YLRctNatViewController alloc] init];
    flutterVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"ReactNative" image:[UIImage imageNamed:@"react"] tag:4];
    
    YLNativeNewsViewController *homeVC = [[YLNativeNewsViewController alloc] initWithNibName:@"YLNativeNewsViewController" bundle:nil];
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Native" image:[UIImage imageNamed:@"apple"] tag:5];
//    homeVC.tabBarItem.selectedImage = []
    UINavigationController *naviUser = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    tab.tabBar.translucent = NO;
    tab.viewControllers = @[naviNote,naviAlgori,naviSwift,flutterVC,naviUser];
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    
    return YES;
}

/// UINavigationBar & UITabBar appearance
- (void)appearanceSetting {
    if (@available(iOS 15.0, *)) {
        // UINavigationBar
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        appearance.backgroundColor =  [YLTheme main].themeColor; //背景色
        appearance.shadowColor = UIColor.clearColor; //阴影
        appearance.titleTextAttributes = @{NSFontAttributeName:[YLTheme main].mainFont,NSForegroundColorAttributeName:[YLTheme main].backColor}; // title 字体、颜色
        appearance.backButtonAppearance.normal.titleTextAttributes = @{NSFontAttributeName:[YLTheme main].mainFont,NSForegroundColorAttributeName:[YLTheme main].backColor}; // back item 字体、颜色
        [UINavigationBar appearance].tintColor = [YLTheme main].naviTintColor; // bar上控件的颜色
        appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffsetMake(-200, 0);  // UINavigationBarAppearance 会覆盖原有的导航栏设置，这里需要重新设置返回按钮隐藏，不隐藏可注释或删掉
        [[UINavigationBar appearance] setStandardAppearance:appearance];
        [[UINavigationBar appearance] setScrollEdgeAppearance:appearance];
        
        // UITabBar
        UITabBarAppearance *tabAppearance = [[UITabBarAppearance alloc] init];
        tabAppearance.stackedLayoutAppearance.selected.iconColor = [YLTheme main].themeColor;
        tabAppearance.stackedLayoutAppearance.normal.iconColor = [UIColor grayColor];
        //tabBaritem title选中状态颜色
        tabAppearance.stackedLayoutAppearance.selected.titleTextAttributes = @{ NSForegroundColorAttributeName: [YLTheme main].themeColor };
        //tabBaritem title未选中状态颜色
        tabAppearance.stackedLayoutAppearance.normal.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor grayColor] };
        //tabBar背景颜色
        tabAppearance.backgroundColor = [YLTheme main].tabTintColor;
        [[UITabBar appearance] setScrollEdgeAppearance:tabAppearance];
        [[UITabBar appearance] setStandardAppearance:tabAppearance];
        
    } else {
        // UINavigationBar
        // 抹去navigationbar 返回按钮title (推荐)
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
        [UINavigationBar appearance].barTintColor = [YLTheme main].themeColor ; // 背景色
        [UINavigationBar appearance].tintColor = [YLTheme main].naviTintColor; // bar上控件的颜色
        [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName:[YLTheme main].mainFont,NSForegroundColorAttributeName:[YLTheme main].backColor};
        
        // UITabBar
        [UITabBar appearance].barTintColor = [YLTheme main].tabTintColor;
        [UITabBar appearance].tintColor = [YLTheme main].themeColor;
    }
    
    
}

//- (void)checkOrWritePlist:(void(^)(NSDictionary *))completeBlock {
//    NSString * path = [[NSBundle mainBundle] pathForResource:@"Skin" ofType:@"plist"];
//    NSMutableDictionary * mutDic = [NSMutableDictionary dictionary];
//
//    if (path == nil) {
//        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] ;
//        NSString *infoFilePath = [cachesPath stringByAppendingPathComponent:@"Skin.plist"];
//
//        [mutDic setValue:@{@"color":@"DC143C"} forKey:@"red"];
//        [mutDic setValue:@{@"color":@"FF00F0"} forKey:@"blue"];
//        [mutDic setValue:@{@"color":@"fd9c2e"} forKey:@"yellow"];
//        [mutDic setValue:@"blue" forKey:@"selectColor"];
//        [mutDic setValue:@"yellow" forKey:@"tintColor"];
//
//        [mutDic writeToFile:infoFilePath atomically:YES];
//    }
//    if (completeBlock) {
//        completeBlock([mutDic copy]);
//    }
//}
- (void)rctConfig {
    
}
@end
