//
//  YLThreadOperationSyncController.m
//  YLNote
//
//  Created by tangh on 2022/2/21.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLThreadOperationSyncController.h"
#import <Masonry/Masonry.h>
#import "YLImageView.h"
#import "YLOperationSync.h"

@interface YLThreadOperationSyncController ()
@property(nonatomic,strong) NSArray *imageList;
@property(nonatomic,strong) NSMutableArray<YLImageView*> *allImageViews;

@end

@implementation YLThreadOperationSyncController

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
    [start setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [start setTitle:@"download" forState:UIControlStateNormal];
    [start setBackgroundColor:[UIColor lightGrayColor]];
    [start addTarget:self action:@selector(downloadStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
    [start mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(150);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
        
    for (NSInteger i =0; i<self.imageList.count; i++) {
        YLImageView *imgView = [[YLImageView alloc] initWithFrame:CGRectMake(30+90*i, 200, 80, 100)];
        imgView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:imgView];
        [self.allImageViews addObject:imgView];
    }
}

#pragma mark - actions

/// 添加4个同步任务，按顺序执行，执行完最后才打印后面的log:"---同步执行---"
- (void)downloadStart {
    for (NSInteger i =0 ;i<self.allImageViews.count;i++) {
        YLOperationSync *op = [[YLOperationSync alloc] init];
        op.opID = [NSString stringWithFormat:@"%ld",1000+i];
        NSLog(@"😄服务质量：%ld",op.qualityOfService);
        op.url = self.imageList[i];
        op.finishBlock = ^(NSData * _Nonnull data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.allImageViews[i].image = [UIImage imageWithData:data];
            });
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
        [op start];
    }
    
    NSLog(@"---同步执行---");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    YLOperationSync *op = (YLOperationSync *)object;
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

- (NSMutableArray<YLImageView *> *)allImageViews {
    if (!_allImageViews) {
        _allImageViews = [NSMutableArray array];
    }
    return _allImageViews;
}


@end
