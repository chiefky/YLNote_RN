//
//  YLNatiFilmDetailViewController.m
//  YLNote
//
//  Created by tangh on 2022/6/7.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLNatiFilmDetailViewController.h"
#import "YLNoteBridgeAPI.h"
#import <React/RCTRootView.h>
#import "YLRNTEventManager.h"

@interface YLNatiFilmDetailViewController ()

@end

@implementation YLNatiFilmDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self initRCTRootView];
}

- (void)initRCTRootView{
    RCTRootView *rootView = [[RCTRootView alloc]initWithBridge:[YLNoteBridgeAPI shareInstance] moduleName:@"Detail" initialProperties:  @{@"filmId":self.filmId}];
    self.view = rootView;
    
}

- (void)setupUI {
    NSDictionary *dict = @{@"f_id": self.filmId};
    [YLRNTEventManager postEventWithName:@"selectItem" parameter:dict];
}

@end
