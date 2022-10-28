//
//  YLThreadOperationAsyncController.m
//  YLNote
//
//  Created by tangh on 2022/2/21.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLThreadOperationAsyncController.h"
#import <Masonry/Masonry.h>
#import "YLOperationConcurrent.h"
#import "YLOperationAsync.h"
#import "YLImageView.h"
#import "YLNote-Swift.h"

@interface YLThreadOperationAsyncController ()
@property(nonatomic,strong) NSArray *imageList;
@property(nonatomic,strong) NSMutableArray<YLImageView*> *allImageViews;

@end

@implementation YLThreadOperationAsyncController

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageList = @[
        @"https://img.youxiniao.com/uploads/allimg/160203/60-160203113159-50.jpg",
        @"http://n.sinaimg.cn/sinacn15/273/w500h573/20180611/ea32-hcufqif9934832.jpg",
        @"https://a-static.besthdwallpaper.com/piao-bai-ji-ulquiorra-ciferdi-er-ban-qiangzhi-tw-1080x1920-71786_165.jpg",
        @"https://www.itsfun.com.tw/images/2e/11/nBnauU2MzYWO3MjY1YDMhFjZ2QWMwQ3Lt92Yuc2cthWcuw2cz5SMw9yL6MHc0RHa.jpg",
    ];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
  
    UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
    [start setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [start setTitle:@"download" forState:UIControlStateNormal];
    [start setBackgroundColor:[YLTheme main].themeColor];
    [start addTarget:self action:@selector(downloadStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
    [start mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
        
    for (NSInteger i =0; i<self.imageList.count; i++) {
        YLImageView *imgView = [[YLImageView alloc] initWithFrame:CGRectMake(30+90*i, 200, 80, 100)];
        imgView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:imgView];
        [self.allImageViews addObject:imgView];
    }
}

#pragma mark - actions
/// 添加4个任务到队列，0.3秒后取消所有任务，已经执行完的任务1无法取消掉（异步任务，执行任务前打印log:"---异步任务---"）
- (void)downloadStart {
    NSOperationQueue *queue = [NSOperationQueue new];
    YLOperationAsync * pre = nil;
    for (NSInteger i =0 ;i<self.allImageViews.count;i++) {
        YLOperationAsync *op = [[YLOperationAsync alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.imageList[i]]]];
        if (pre) {
            [op addDependency:pre];
        }
        pre = op;
        op.opID = [NSString stringWithFormat:@"%ld",1000+i];
        op.completionHandler = ^(YLOperationAsyncSessionResult status, NSError * _Nullable error, NSData * _Nullable imageData) {
            if (imageData && status == YLOperationAsyncSessionResultSuccess) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.allImageViews[i].image = [UIImage imageWithData:imageData];
                });
            } else if (!imageData && status == YLOperationAsyncSessionResultCanceled) {
                NSLog(@"Finished but cancelled,error：%@",error.description);
            } else {
                NSLog(@"Finished error：%@",error.description);
            }
        };

        [op addObserver:self forKeyPath:@"executing" options:NSKeyValueObservingOptionNew context:nil];
        [op addObserver:self forKeyPath:@"cancelled" options:NSKeyValueObservingOptionNew context:nil];
        [op addObserver:self forKeyPath:@"finished" options:NSKeyValueObservingOptionNew context:nil];
        __weak typeof(op) wkOP = op;
        op.completionBlock = ^{
            [wkOP removeObserver:self forKeyPath:@"executing"];
            [wkOP removeObserver:self forKeyPath:@"cancelled"];
            [wkOP removeObserver:self forKeyPath:@"finished"];
        };
        [queue addOperation:op];
    }
    NSLog(@"---异步任务---");
    // 0.3秒后取消所有任务
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [queue cancelAllOperations];
    });


}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    YLOperationAsync *op = (YLOperationAsync *)object;
    NSInteger index = [op.opID integerValue] - 1000;
    YLImageView *imgView = self.allImageViews[index];
    if ([keyPath isEqualToString:@"executing"] && [change[NSKeyValueChangeNewKey] boolValue] == YES) {
        NSLog(@"🍎 executing: %@",op.opID);
        dispatch_async(dispatch_get_main_queue(), ^{
        
            imgView.titleLabel.text = [NSString stringWithFormat:@"%@ executing",op.opID];
            imgView.titleLabel.textColor = [UIColor redColor];
        });
    } else if ([keyPath isEqualToString:@"finished"]) {
        NSLog(@"🍊 finished: %@",op.opID);
        dispatch_async(dispatch_get_main_queue(), ^{
            imgView.titleLabel.text = [NSString stringWithFormat:@"%@ finished",op.opID];

            imgView.titleLabel.textColor = [UIColor greenColor];

        });
    }  else if ([keyPath isEqualToString:@"cancelled"]) {
        NSLog(@"🍌 cancelled: %@",op.opID);
        dispatch_async(dispatch_get_main_queue(), ^{
            imgView.titleLabel.text = [NSString stringWithFormat:@"%@ cancelled",op.opID];
            imgView.titleLabel.textColor = [UIColor greenColor];

        });
    }

}
#pragma mark - lazy
- (NSMutableArray<YLImageView *> *)allImageViews {
    if (!_allImageViews) {
        _allImageViews = [NSMutableArray array];
    }
    return _allImageViews;
}

@end
