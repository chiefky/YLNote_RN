//
//  YLLifeCycleView.m
//  YLNote
//
//  Created by tangh on 2022/5/24.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLLifeCycleView.h"

@implementation YLLifeCycleView


//构造方法,初始化时调用,不会调用init方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    NSLog(@"%s",__FUNCTION__);
    return self;
}
//添加子控件时调用
- (void)didAddSubview:(UIView *)subview {
    NSLog(@"%s",__FUNCTION__);
}
//构造方法,内部会调用initWithFrame方法
- (instancetype)init {
    self = [super init];
    NSLog(@"%s",__FUNCTION__);
    return self;
}
//xib归档初始化视图后调用,如果xib中添加了子控件会在didAddSubview方法调用后调用
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    NSLog(@"%s",__FUNCTION__);
    return self;
    
}
//唤醒xib,可以布局子控件
- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%s",__FUNCTION__);
}

//父视图将要更改为指定的父视图,当前视图被添加到父视图时调用
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    NSLog(@"%s",__FUNCTION__);
}
//父视图已更改
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    NSLog(@"%s",__FUNCTION__);
}
//其窗口对象将要更改
- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    NSLog(@"%s",__FUNCTION__);
}
//窗口对象已经更改
- (void)didMoveToWindow{
    [super didMoveToWindow];
    NSLog(@"%s",__FUNCTION__);

}
//布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%s",__FUNCTION__);
}
//绘制视图
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    NSLog(@"%s",__FUNCTION__);
}

//将要移除子控件
- (void)willRemoveSubview:(UIView *)subview {
    [super willRemoveSubview:subview];
    NSLog(@"%s",__FUNCTION__);
}

//从父控件中移除
- (void)removeFromSuperview {
    [super removeFromSuperview];
    NSLog(@"%s",__FUNCTION__);
}
//销毁
- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);

}

@end
