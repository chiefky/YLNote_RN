//
//  YLResponderMyDemoController.m
//  YLNote
//
//  Created by tangh on 2023/2/14.
//  Copyright © 2023 tangh. All rights reserved.
//

#import "YLResponderMyDemoController.h"
#import "YLL/YLLView.h"
#import "YLL/YLLButton.h"
#import "YLL/YLLGestureRecognizer.h"
#import "YLNote-Swift.h"

@interface YLResponderMyDemoController ()
@property(nonatomic,strong) YLLView *rootView;
@property(nonatomic,strong) YLLView *yll_view;
@property(nonatomic,strong) YLLabel *yll_label;

@property(nonatomic,strong) YLLGestureRecognizer *yll_gesture;
@property(nonatomic,strong) YLLButton *yll_button;

@end

@implementation YLResponderMyDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rootView];
    self.yll_gesture = [[YLLGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    

    [self.rootView addSubview:self.yll_button];
    
    [self.yll_button addSubview:self.yll_view];

    [self.rootView addGestureRecognizer:self.yll_gesture];

    
    
//    YLLView *testView1 = [[YLLView alloc] initWithFrame:CGRectMake(60, 480, 300, 100)];
//    testView1.backgroundColor = [UIColor purpleColor];
//    [self.rootView addSubview:testView1];
//
//    YLLView *testView2 = [[YLLView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
//    testView2.backgroundColor = [UIColor greenColor];
//    [testView1 addSubview:testView2];
//
//    YLLView *testView3 = [[YLLView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
//    testView3.backgroundColor = [UIColor blueColor];
//    [testView2 addSubview:testView3];
}

- (YLLView *)rootView {
    if (!_rootView) {
        _rootView = [[YLLView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _rootView.backgroundColor = [UIColor lightGrayColor];
    }
    return _rootView;
}

- (YLLView *)yll_view {
    if (!_yll_view) {
        _yll_view = [[YLLView alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
        _yll_view.backgroundColor = [UIColor yellowColor];

    }
    return _yll_view;
}

- (YLLabel *)yll_label {
    if (!_yll_label) {
        _yll_label = [[YLLabel alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
        _yll_label.backgroundColor = [UIColor whiteColor];
        _yll_label.text = @"这是一个Label";
        _yll_label.textColor = [UIColor systemPinkColor];
    }
    return _yll_label;
}


- (YLLButton *)yll_button {
    if (!_yll_button) {
        _yll_button = [[YLLButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-150,200, 300, 200)];
        _yll_button.backgroundColor = [UIColor systemPinkColor];
        [_yll_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yll_button;
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹：button clicked");
}

- (void)gestureAction:(id)sender {
    NSLog(@"🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹：gesture clicked");
}
@end
