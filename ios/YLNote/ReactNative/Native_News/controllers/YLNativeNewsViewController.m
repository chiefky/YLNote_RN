//
//  YLNativeNewsViewController.m
//  YLNote
//
//  Created by tangh on 2022/5/25.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLNativeNewsViewController.h"
#import <Masonry/Masonry.h>
#import "YLNatiFilmListViewController.h"
#import "YLFilmTabView.h"
#import "YLSearchBarBackView.h"
#import "YLDefaultMacro.h"
#import "YLNote-Swift.h"

static NSInteger tab_width = 80;

@interface YLNativeNewsViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) YLSearchBarBackView *searchBarBackView;
@property (weak, nonatomic) IBOutlet UIView *searchHeaderView;
@property (weak, nonatomic) IBOutlet UIScrollView *tabScroll;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (strong, nonatomic) UIScrollView *tabScrollView;
@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIView *main_contentView;
@property (strong, nonatomic) UIView *tabUnderlineView;

@property (copy, nonatomic) NSArray *tabsArray;
@property (copy, nonatomic) NSArray *swipsArray;
@property (assign, nonatomic) NSInteger currentPage;

@end

@implementation YLNativeNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInitalDatas];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = UIColorFromHex(@"#F8F8FF");
    [self.searchHeaderView addSubview:self.searchBarBackView];
    [self.searchBarBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(33);
        make.left.mas_equalTo(10+45+20);
        make.right.mas_equalTo(-10-27-20);
    }];
    
    self.tabScroll.contentSize = CGSizeMake(self.tabsArray.count * tab_width, 0);
    self.mainScroll.contentSize = CGSizeMake(self.tabsArray.count * YLSCREEN_WIDTH, 0);
    self.mainScroll.delegate = self;

    [self.tabsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 设置标签
        YLFilmTabView *tabView = [[YLFilmTabView alloc] initWithName:obj];
        [self.tabScroll addSubview:tabView];
        tabView.tabClickHandler = ^{
            NSUInteger toPage = idx;
            NSInteger fromPage = self.currentPage;
            if (toPage != fromPage) {
                [self animationFromPage:fromPage toPage:toPage];
            }
        };
        tabView.selected = idx == self.currentPage;
        [tabView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(tab_width);
            make.left.mas_equalTo(tab_width * idx);
            make.height.mas_equalTo(40);
        }];
        //设置子控制器
        YLNatiFilmListViewController *recl = [[YLNatiFilmListViewController alloc] initWithNibName:@"YLRecyleListViewController" bundle:nil];
        if (recl) {
//            recl.title = [NSString stringWithFormat:@"%ld:%@",idx,obj];
            [self addChildViewController:recl];
        }
    }];
    
    if (0 == self.currentPage) {
        self.tabUnderlineView = [UIView new];
        self.tabUnderlineView.backgroundColor = UIColorFromHex(@"#b80234");
        [self.tabScroll addSubview:self.tabUnderlineView];
        self.tabUnderlineView.frame = CGRectMake(20, 41, tab_width-40, 4);
    }
    
    [self setupMainUI];
}

- (void)setupMainUI {
    UIViewController *currentVC = self.childViewControllers[self.currentPage];
    [self.mainScroll addSubview:currentVC.view];
    CGRect currentVCFrame = self.mainScroll.frame;
    currentVCFrame.origin.x = self.mainScroll.contentOffset.x;
    currentVCFrame.origin.y = 0;
    currentVC.view.frame = currentVCFrame;

}

- (void)setupInitalDatas {
    self.tabsArray = @[@"抗疫",@"头条",@"娱乐",@"科技",@"手机",@"电影",@"财经",@"房产"];
    self.swipsArray = @[
          @"华为不看好5G",
          @"陶渊明后人做主播",
          @"尔康制药遭处罚",
          @"卢恩光行贿一案受审",
          @"盖茨力挺扎克伯格",
          @"大连特大刑事案件",
          @"高校迷香盗窃案",
          @"少年被批评后溺亡",
          @"北京工商约谈抖音"];
}

- (void)tabClickHandler:(UIButton *)sender {
    
}

- (IBAction)hourClickAction:(id)sender {
}
- (IBAction)logoClickAction:(id)sender {
}
/// 选中下划线frame修改
/// @param toPage 目标标签对应的Page
- (void)moveUnderlineToPage:(NSInteger)toPage {
    float toLeading = toPage * tab_width + 20;
    self.tabUnderlineView.frame = CGRectMake(toLeading, 41, tab_width-40, 4);
}

/// 设置tabScroll内容偏移
- (void)settabScrollContenOffset {
    CGFloat x = self.tabUnderlineView.center.x - YLSCREEN_WIDTH / 2;
    CGFloat maxOffset = self.tabScroll.contentSize.width - YLSCREEN_WIDTH;// 最大偏移量，不能超过contentsize大小
    x = x<0 ? 0 : (x>maxOffset ? maxOffset : x);
    [self.tabScroll setContentOffset:CGPointMake(x, 0)];
}

/// 利用普通动画完成
/// @param toPage <#toPage description#>
- (void)doMoving1ToPage:(NSInteger)toPage {
    [UIView animateWithDuration:0.5 animations:^{
        // move underline offsetPage * tabWidth
        [self moveUnderlineToPage:toPage];
    } completion:^(BOOL finished) {
        // set tabScroll contentoffset：（下划线中心x向前前进多少,就把scrollview向前偏移多少，才能保证中心在一条线上）
        [UIView animateWithDuration:0.5 animations:^{
            [self settabScrollContenOffset];
        }];
    } ];

}

/// 转场
/// @param frompage 前视图
/// @param topage 后视图
- (void)animationFromPage:(NSInteger)frompage toPage:(NSInteger)topage {
    // 添加移动动画
    
    UIViewController *fromVC = self.childViewControllers[frompage];
    UIViewController *toVC = self.childViewControllers[topage];
    __weak typeof(self) weakSelf = self;
    [self transitionFromViewController:fromVC toViewController:toVC duration:1 options:UIViewAnimationOptionTransitionNone animations:^{
            [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionOverrideInheritedOptions animations:^{
                [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1.0/3 animations:^{
                    [self moveUnderlineToPage:topage];
                }];
        
                [UIView addKeyframeWithRelativeStartTime:2.0/3 relativeDuration:1.0/3 animations:^{
                    [self settabScrollContenOffset];
                }];
            } completion:nil];
    } completion:^(BOOL finished) {
        NSLog(@"is finished");
        self.currentPage = topage; // 设置当前页码
        self.title = toVC.title; // 设置当前标题
        CGRect toVCFrame = weakSelf.mainScroll.frame; // 修改新添加视图的frame
        toVCFrame.origin.x = weakSelf.mainScroll.contentOffset.x;
        toVCFrame.origin.y = 0;
        toVC.view.frame = toVCFrame;
    }];

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%s",__func__);

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.mainScroll) {
        NSInteger toPage = floorf(scrollView.contentOffset.x / YLSCREEN_WIDTH);
        NSInteger fromPage = self.currentPage;
        if (toPage != fromPage) {
            [self animationFromPage:fromPage toPage:toPage];
        }
       
    }
}

#pragma mark - lazy
- (YLSearchBarBackView *)searchBarBackView {
    if (!_searchBarBackView) {
        _searchBarBackView = (YLSearchBarBackView *)[[NSBundle  mainBundle]loadNibNamed:@"YLSearchBarBackView" owner:self options:nil ].firstObject;
    }
    return _searchBarBackView;
}

- (NSArray *)swipsArray {
    if (!_swipsArray) {
        _swipsArray = [NSArray array];
    }
    return _swipsArray;
}
@end
