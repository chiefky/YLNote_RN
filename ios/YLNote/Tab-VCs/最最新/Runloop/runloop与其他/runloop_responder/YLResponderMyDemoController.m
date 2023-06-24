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
@property(nonatomic,strong) YLLView *yellowView;
@property(nonatomic,strong) YLLabel *blueLabel;

@property(nonatomic,strong) YLLGestureRecognizer *yll_gesture;
@property(nonatomic,strong) YLLButton *pinkButton;

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
    

    
    [self.rootView addSubview:self.yellowView];
    [self.rootView addSubview:self.pinkButton];

//    [self.rootView addGestureRecognizer:self.yll_gesture];

    
    
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

- (YLLView *)yellowView {
    if (!_yellowView) {
        _yellowView = [[YLLView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-150,200, 300, 200)];
        _yellowView.backgroundColor = [UIColor yellowColor];

    }
    return _yellowView;
}

- (YLLabel *)blueLabel {
    if (!_blueLabel) {
        _blueLabel = [[YLLabel alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
        _blueLabel.backgroundColor = [UIColor blueColor];
        _blueLabel.text = @"这是一个Label";
        _blueLabel.textColor = [UIColor systemPinkColor];
    }
    return _blueLabel;
}


- (YLLButton *)pinkButton {
    if (!_pinkButton) {
        _pinkButton = [[YLLButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-150,200, 100, 100)];
        _pinkButton.backgroundColor = [UIColor systemPinkColor];
        [_pinkButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pinkButton;
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹：button clicked");
}

- (void)gestureAction:(id)sender {
    NSLog(@"🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹：gesture clicked");
}
@end
