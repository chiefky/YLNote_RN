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

@interface YLRctNatViewController ()

@end

@implementation YLRctNatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self initRCTRootView];
}
- (void)initRCTRootView{
    NSLog(@"RNTest Button Pressed");

    RCTRootView *rootView = [[RCTRootView alloc]initWithBridge:[YLNoteBridgeAPI shareInstance]
                                            moduleName:@"Home"
                                     initialProperties:  nil];
    self.view = rootView;
    

}
- (IBAction)highScoreButtonPressed:(id)sender {
    NSLog(@"High Score Button Pressed");
   

}
- (void)setupUI {
    
}

#pragma mark - tests

@end
