//
//  YLNatiFilmDetailViewController.m
//  YLNote
//
//  Created by tangh on 2022/6/7.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLNatiFilmDetailViewController.h"
#import <React/RCTRootView.h>
#import "YLNoteBridgeAPI.h"

@interface YLNatiFilmDetailViewController ()

@end

@implementation YLNatiFilmDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI{
    RCTRootView *rootView = [[RCTRootView alloc]initWithBridge:[YLNoteBridgeAPI shareInstance] moduleName:@"Detail" initialProperties:  @{@"filmId":self.filmId}];
    self.view = rootView;
}


@end
