//
//  YLSearchBarBackView.m
//  YLNote
//
//  Created by tangh on 2022/5/26.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLSearchBarBackView.h"
#import <Masonry/Masonry.h>
#import "YLDefaultMacro.h"

@interface YLSearchBarBackView ()
@property (strong, nonatomic) UIView *cornerBackView;
@property (copy, nonatomic) NSArray *datas;
@property (weak, nonatomic) IBOutlet UIView *swipsView;
@property (weak, nonatomic) IBOutlet UILabel *swipsLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *swipsCentY;
@property (assign,nonatomic) NSInteger curADIndex;
@end

@implementation YLSearchBarBackView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSLog(@"s;;;%s",__FUNCTION__);
    [self settingup];
}

- (void)updateConstraints {
    [super updateConstraints];
    NSLog(@"%@,%@",NSStringFromCGRect(self.frame),NSStringFromCGRect(self.swipsView.frame));
    //    self.swipsCentY.constant = -23;
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self doAnimation];
    }];

}

- (void)doAnimation {
//    1-退场
    [self exitAnimation];
//    2-赋值
//    self.curADIndex++;
//    if (self.curADIndex == self.datas.count) {
//        self.curADIndex = 0;
//    }
//    self.swipsLabel.text = self.datas[self.curADIndex];
//    NSLog(@"广告：%@",self.datas[self.curADIndex]);
//    self.swipsLabel.alpha = 1;
////    2-进场
//    [self enteryAnimation];
}


- (void)settingup {
    //    [self.swipsView mas_makeConstraints:^(MASConstraintMaker *make) {
    //                make.centerX.mas_equalTo(0);
    //                make.centerY.mas_equalTo(0);
    //                make.height.mas_offset(17);
    //                make.width.mas_equalTo(150);
    //    }];
    
    self.cornerBackView = [UIView new];
    [self addSubview:self.cornerBackView];
    [self.cornerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.cornerBackView.alpha = 0.3;
    self.cornerBackView.layer.cornerRadius = self.bounds.size.height/2;
    self.cornerBackView.backgroundColor = [UIColor whiteColor];
    
    self.datas = @[
        @"华为不看好5G",
        @"陶渊明后人做主播",
        @"尔康制药遭处罚",
        @"卢恩光行贿一案受审",
        @"盖茨力挺扎克伯格",
        @"大连特大刑事案件",
        @"高校迷香盗窃案",
        @"少年被批评后溺亡",
        @"北京工商约谈抖音"];
    self.swipsLabel.text = self.datas[0];
    
}

- (void)exitAnimation {
    
//    [UIView animateKeyframesWithDuration:1.f
//                                   delay:0
//                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
//                              animations:^{
//        [UIView addKeyframeWithRelativeStartTime:0.0   // 相对于6秒所开始的时间（第0秒开始动画）
//                                relativeDuration:1/2.0 // 相对于6秒动画的持续时间（动画持续2秒）
//                                      animations:^{
//
//        }];
//
//        [UIView addKeyframeWithRelativeStartTime:1/2.0 // 相对于6秒所开始的时间（第2秒开始动画）
//                                relativeDuration:1/2.0 // 相对于6秒动画的持续时间（动画持续2秒）
//                                      animations:^{
//
//        }];
//    }
//                              completion:^(BOOL finished) {
//        NSLog(@"====over");
//    }];
    
    [UIView animateWithDuration:0.5f animations:^{
        self.swipsView.alpha = 0;
        CGRect frame = self.swipsView.frame;
        frame.origin.y -= 17 ;
        self.swipsView.frame = frame;
    } completion:^(BOOL finished) {
        CGRect frame = self.swipsView.frame;
        frame.origin.y += 30 ;
        self.swipsView.frame = frame;
        
        [self enteryAnimation];
    }];
}

- (void)enteryAnimation {
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = self.swipsView.frame;
        frame.origin.y -= 13 ;
        self.swipsView.frame = frame;
        self.swipsView.alpha = 1;
    }];
    
}
@end
