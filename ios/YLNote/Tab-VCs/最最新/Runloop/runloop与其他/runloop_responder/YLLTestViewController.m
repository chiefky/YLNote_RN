//
//  YLLTestViewController.m
//  YLNote
//
//  Created by tangh on 2023/2/14.
//  Copyright © 2023 tangh. All rights reserved.
//

#import "YLLTestViewController.h"
#import "YLL/YLLView.h"
#import "YLL/YLLButton.h"
#import "YLL/YLLGestureRecognizer.h"

@interface YLLTestViewController ()
@property(nonatomic,strong) YLLView *rootView;
@property(nonatomic,strong) YLLView *yll_view;
@property(nonatomic,strong) YLLGestureRecognizer *yll_gesture;
@property(nonatomic,strong) YLLButton *yll_button;

@end

@implementation YLLTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rootView];
    
    [self.rootView addSubview:self.yll_button];
    [self.yll_button addSubview:self.yll_view];
    
    YLLView *testView1 = [[YLLView alloc] initWithFrame:CGRectMake(40, 200, 100, 80)];
    testView1.backgroundColor = [UIColor purpleColor];
    [self.rootView addSubview:testView1];
    
    YLLView *testView2 = [[YLLView alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    testView2.backgroundColor = [UIColor greenColor];
    [testView1 addSubview:testView2];
    
    YLLView *testView3 = [[YLLView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    testView3.backgroundColor = [UIColor blueColor];
    [testView2 addSubview:testView3];
//    YLLGestureRecognizer *tap = [[YLLGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
//    [self.view addGestureRecognizer:tap];
    
}
- (YLLView *)rootView {
    if (!_rootView) {
        _rootView = [[YLLView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
        _rootView.backgroundColor = [UIColor lightGrayColor];
    }
    return _rootView;
}

- (YLLView *)yll_view {
    if (!_yll_view) {
        _yll_view = [[YLLView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        _yll_view.backgroundColor = [UIColor yellowColor];

    }
    return _yll_view;
}

- (YLLButton *)yll_button {
    if (!_yll_button) {
        _yll_button = [[YLLButton alloc] initWithFrame:CGRectMake(80,100, 100, 40)];
        _yll_button.backgroundColor = [UIColor systemPinkColor];
        [_yll_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yll_button;
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"button clicked");
}

- (void)gestureAction:(id)sender {
    NSLog(@"gesture clicked");
}
@end
