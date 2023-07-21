//
//  YLLifeCycleView.m
//  YLNote
//
//  Created by tangh on 2022/5/24.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLLifeCycleView.h"

@implementation YLLifeCycleView

//构造方法,内部会调用initWithFrame方法
- (instancetype)init {
    NSLog(@"%s: ",__FUNCTION__);
    self = [super init];
    return self;
}

//构造方法,初始化时调用,不会调用init方法
- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"%s: ",__FUNCTION__);
    self = [super initWithFrame:frame];
    return self;
}

//xib归档初始化视图后调用,如果xib中添加了子控件会在didAddSubview方法调用后调用
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"%s: ",__FUNCTION__);
    self = [super initWithCoder:aDecoder];
    return self;
    
}

//唤醒xib,可以布局子控件
- (void)awakeFromNib {
    NSLog(@"%s: ",__FUNCTION__);
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone; // 解决xib初始化view，setFrame无效

}

//添加子控件时调用
- (void)didAddSubview:(UIView *)subview {
    NSLog(@"%s: ",__FUNCTION__);
}

//父视图将要更改为指定的父视图,当前视图被添加到父视图时调用
- (void)willMoveToSuperview:(UIView *)newSuperview {
    NSLog(@"%s: ",__FUNCTION__);
    [super willMoveToSuperview:newSuperview];
}
//父视图已更改
- (void)didMoveToSuperview {
    NSLog(@"%s: ",__FUNCTION__);
    [super didMoveToSuperview];
}
//其窗口对象将要更改
- (void)willMoveToWindow:(UIWindow *)newWindow {
    NSLog(@"%s: ",__FUNCTION__);
    [super willMoveToWindow:newWindow];
}
//窗口对象已经更改
- (void)didMoveToWindow{
    NSLog(@"%s: ",__FUNCTION__);
    [super didMoveToWindow];

}
//布局子控件
- (void)layoutSubviews {
    NSLog(@"%s: ",__FUNCTION__);
    [super layoutSubviews];
}
//绘制视图;通过xib文件创建的view在结束布局后进行绘制
- (void)drawRect:(CGRect)rect {
    NSLog(@"%s: ",__FUNCTION__);
    [super drawRect:rect];
}

//将要移除子控件
- (void)willRemoveSubview:(UIView *)subview {
    NSLog(@"%s: ",__FUNCTION__);
    [super willRemoveSubview:subview];
}


//从父控件中移除
- (void)removeFromSuperview {
    NSLog(@"%s: ",__FUNCTION__);
    [super removeFromSuperview];
}
//销毁
- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);

}

@end
