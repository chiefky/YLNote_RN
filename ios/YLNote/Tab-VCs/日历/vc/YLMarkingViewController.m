//
//  YLMarkingViewController.m
//  YLNote
//
//  Created by tangh on 2022/9/16.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLMarkingViewController.h"
#import "YLNote-Swift.h"
#import "WXApi.h"
#import "YLCalendarView.h"
#import <Masonry/Masonry.h>
#import "YLSetting.h"
#import "YLCalendarDBManager.h"
#import "YLDate.h"
#import "NSDate+Tool.h"

@interface YLMarkingViewController ()
@property (nonatomic, strong) YLCalendarView *calendarView;
@property (nonatomic, strong) UIButton *recordButn;
@property (nonatomic, strong) UILabel *textTitleLabel;
@property (nonatomic, strong) UITextView *textView;

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
    
    UIView *weekView = [self setWeekViewday];
    self.calendarView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.calendarView];
    [self.calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(weekView.mas_bottom);
        make.height.mas_equalTo(300);
    }];

    [self.recordButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.calendarView.mas_bottom).offset(50);
        make.centerX.mas_equalTo(self.calendarView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.textTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.recordButn.mas_bottom).offset(20);
    }];

    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(50);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.textTitleLabel.mas_bottom).offset(10);
    }];
//    if (@available(iOS 14,*)) {
//        self.algoButn.showsMenuAsPrimaryAction = YES;
//        self.algoButn.menu = [UIMenu menuWithChildren:@[
//            [UIAction actionWithTitle:@"1" image:[UIImage imageNamed:@"search"] identifier:@"1" handler:^(__kindof UIAction * _Nonnull action) {
//            NSLog(@"Select Messages");
//        }],
//             [UIAction actionWithTitle:@"Select Messages 2" image:[UIImage imageNamed:@"search"] identifier:@"2" handler:^(__kindof UIAction * _Nonnull action) {
//             
//         }],
//              [UIAction actionWithTitle:@"Select Messages 3" image:[UIImage imageNamed:@"search"] identifier:@"3" handler:^(__kindof UIAction * _Nonnull action) {
//              
//          }],
//            ]];
//    } else {
//        
//    }
}

- (void)refreshUI {
    [self.calendarView reloadData];
    self.recordButn.enabled = ![self todayIsMarked];
}

#pragma mark - 设置日历顶部的周几显示控件
- (UIView *)setWeekViewday {
    UIView *weekView = [[UIView alloc] init];
    [self.view addSubview:weekView];
    weekView.backgroundColor = [YLTheme main].subColor1;
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
        [weekView addSubview:weekTitleLable];
        [weekTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weekTitleWidth*i);
            make.width.mas_equalTo(weekTitleWidth);
            make.centerY.mas_equalTo(weekView);
            make.height.mas_equalTo(20);
        }];
    }
    
    CGFloat topHeight = [YLSetting defaultSettingCenter].statusBarHeight + self.navigationController.navigationBar.frame.size.height;
    [weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(topHeight);
        make.height.mas_equalTo(30);
    }];
    return weekView;
    
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

- (YLCalendarView *)calendarView {
    if (!_calendarView) {
        _calendarView = [[YLCalendarView alloc]initWithFrame:CGRectZero];
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
        [self.view addSubview:_recordButn];
    }
    return _recordButn;
}
- (UILabel *)textTitleLabel {
    if (!_textTitleLabel) {
        _textTitleLabel = [UILabel new];
        _textTitleLabel.text = @"今日内容：";
        _textTitleLabel.textColor = [YLTheme main].textColor;
        _textTitleLabel.font = [YLTheme main].mainFont;
        [self.view addSubview:_textTitleLabel];
    }
    return _textTitleLabel;
}
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [[YLTheme main] subColor1];
        [self.view addSubview:_textView];
    }
    return _textView;
}

@end
