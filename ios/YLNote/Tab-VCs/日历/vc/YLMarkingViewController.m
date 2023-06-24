//
//  YLMarkingViewController.m
//  YLNote
//
//  Created by tangh on 2022/9/16.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLMarkingViewController.h"
#import <Masonry/Masonry.h>
#import "YLNote-Swift.h"
#import "YLCalendarView.h"
#import "YLSetting.h"
#import "YLCalendarDBManager.h"
#import "YLDate.h"
#import "NSDate+Tool.h"
#import "YLDefaultMacro.h"

@interface YLMarkingViewController ()<UIScrollViewDelegate,UITextViewDelegate>
@property (nonatomic, strong) YLCalendarView *calendarView;
@property (nonatomic, strong) UIButton *recordButn;
@property (nonatomic, strong) UILabel *textTitleLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *weekView;

@end

@implementation YLMarkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];

    [self refreshUI];
}

- (void)setupUI {
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 27, 27);
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = share;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(YLSCREEN_WIDTH);
        make.height.mas_equalTo(YLSCREEN_HEIGHT);
    }];
    
    [self setupWeekViewday];
    [self.calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.weekView.mas_bottom);
        make.height.mas_equalTo(310);
    }];

    [self.recordButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.calendarView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.calendarView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.textTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.recordButn.mas_bottom).offset(20);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(20);
    }];

    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.textTitleLabel.mas_bottom).offset(10);
    }];
    
}

- (void)refreshUI {
    [self.calendarView reloadData];
    self.recordButn.enabled = ![self todayIsMarked];
}

#pragma mark - 设置日历顶部的周几显示控件
- (void)setupWeekViewday {
    [self.weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    NSArray *weekTitleArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat weekTitleWidth = self.view.bounds.size.width/weekTitleArray.count;
    for (int i = 0; i<weekTitleArray.count; i++) {
        UILabel *weekTitleLable = [[UILabel alloc] init];
        if (i == 0 || i == 6) {
            weekTitleLable.textColor = [YLTheme main].themeColor;
        }else{
            weekTitleLable.textColor = [YLTheme main].subTextColor;
        }
        weekTitleLable.text = [weekTitleArray objectAtIndex:i];
        weekTitleLable.textAlignment = NSTextAlignmentCenter;
        weekTitleLable.font = [UIFont boldSystemFontOfSize:17];
        [self.weekView addSubview:weekTitleLable];
        [weekTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weekTitleWidth*i);
            make.width.mas_equalTo(weekTitleWidth);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(20);
        }];
    }
}
- (BOOL)todayIsMarked {
    NSString *dateId = [[NSDate date] yldate_id];
    YLDate *cacheDate = [[YLCalendarDBManager sharedInstance] searchDateWithID:dateId];
    return cacheDate ? [@(cacheDate.marked) boolValue] : NO;
}

/// 记录打卡
/// @param sender x
- (void)recordAction:(UIButton *)sender {
    // 查询并更新数据库，将marked字段标记为1
    BOOL success = [[YLCalendarDBManager sharedInstance] markedDateWithID:[NSDate date].yldate_id];
    if (success) {
        [self refreshUI];
    } else {
        NSLog(@"打卡失败");
    }
}

/// 分享
/// @param sender x
- (void)shareAction:(UIButton *)sender {
    [self shareWithTitle:self.textView.text content:self.view completeHandler:^(UIActivityType type, BOOL complete, NSArray * items, NSError * error) {
//        NSLog(@"%@",items);
    }];
}
#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
}

#pragma mark - lazy
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.delegate = self;
        _scrollView.scrollEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.contentSize = CGSizeMake(YLSCREEN_WIDTH, YLSCREEN_HEIGHT-150);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
//        _contentView.backgroundColor = [UIColor brownColor];
        [self.scrollView addSubview:_contentView];
    }
    return _contentView;
}

- (YLCalendarView *)calendarView {
    if (!_calendarView) {
        _calendarView = [[YLCalendarView alloc]initWithFrame:CGRectZero];
        _calendarView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_calendarView];
    }
    return  _calendarView;
}

- (UIButton *)recordButn {
    if (!_recordButn) {
        _recordButn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recordButn addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];
        [_recordButn setBackgroundImage:[UIImage imageNamed:@"marked_normal"] forState:UIControlStateNormal];
        [_recordButn setBackgroundImage:[UIImage imageNamed:@"marked_disabled"] forState:UIControlStateDisabled];
        [_recordButn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_recordButn setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        [_recordButn setTitle:@"打卡" forState:UIControlStateNormal];
        [_recordButn setTitle:@"已打卡" forState:UIControlStateDisabled];
//        _recordButn.layer.cornerRadius = 50;
//        _recordButn.layer.masksToBounds = YES;
        [self.contentView addSubview:_recordButn];
    }
    return _recordButn;
}
- (UILabel *)textTitleLabel {
    if (!_textTitleLabel) {
        _textTitleLabel = [UILabel new];
        _textTitleLabel.text = @"今日内容：";
        _textTitleLabel.textColor = [YLTheme main].textColor;
        _textTitleLabel.font = [YLTheme main].mainFont;
        [self.contentView addSubview:_textTitleLabel];
    }
    return _textTitleLabel;
}
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [[YLTheme main] subColor1];
        _textView.delegate = self;
        [self.contentView addSubview:_textView];
    }
    return _textView;
}

- (UIView *)weekView {
    if (!_weekView) {
        _weekView = [UIView new];
        _weekView.backgroundColor = [YLTheme main].subColor1;
        [self.contentView addSubview:_weekView];
    }
    return _weekView;
}

@end
