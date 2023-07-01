//
//  ReactHomeViewController.m
//  YLNote
//
//  Created by tangh on 2023/6/24.
//  Copyright © 2023 tangh. All rights reserved.
//

#import "ReactHomeViewController.h"
#import <React/RCTRootView.h>
#import <React/RCTBundleURLProvider.h>
#import "YLNoteBridgeAPI.h"

@interface ReactHomeViewController ()

@end

@implementation ReactHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:[YLNoteBridgeAPI shareInstance] moduleName:@"RootScreen" initialProperties:  nil];
//    rootView.frame = frame;
//    rootView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.view addSubview:rootView];

    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    UIView *wrapperView = [[UIView alloc] initWithFrame:frame];
    wrapperView.backgroundColor = [UIColor purpleColor];
    wrapperView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:[YLNoteBridgeAPI shareInstance] moduleName:@"RootScreen" initialProperties:  nil];
    rootView.frame = wrapperView.bounds;
    rootView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [wrapperView addSubview:rootView];
    [self.view addSubview:wrapperView];

    
//    NSURL *indexUrl =    [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
//    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:[[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"] moduleName:@"RootScreen" initialProperties:@{} launchOptions:@{}];
    
                             
//                             initWithBridge:[YLNoteBridgeAPI shareInstance]
//                                                    moduleName:@"RootScreen"
//                                             initialProperties:  nil];
//        self.view = rootView;

    // Do any additional setup after loading the view.
}


@end
