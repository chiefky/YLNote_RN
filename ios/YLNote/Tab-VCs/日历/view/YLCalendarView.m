//
//  YLCalendarView.m
//  YLNote
//
//  Created by tangh on 2022/9/18.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLCalendarView.h"
#import "YLCalendarViewCell.h"
#import <Masonry/Masonry.h>
#import "YLCalendarDBManager.h"
#import "YLDateManager.h"
#import "YLDate.h"

static NSString *CALENDAR_SUPPLEMENTARY_IDENTIFIER =@"";
static NSString *CALENDAR_CELL_IDENTIFIER = @"kYLCalendarViewCell";

@interface YLCalendarView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) CGFloat cellWidth;
@property (nonatomic,copy) NSArray<YLDate*> *actualDates;

@end

@implementation YLCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 1; // 列间距
    flowLayout.minimumLineSpacing = 1;// 行间距
//    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    flowLayout.itemSize = CGSizeMake(50, 50);
//    flowLayout.headerReferenceSize = CGSizeMake(self.bounds.size.width, 30);

    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    
    // 注册 cell
    [self.collectionView registerClass:[YLCalendarViewCell class] forCellWithReuseIdentifier:CALENDAR_CELL_IDENTIFIER];
//    [self.collectionView registerClass:[SimpleReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SIMPLESUPPLEMENTARYIDENTIFIER];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.cellWidth = self.bounds.size.width/7 - 1;
    self.collectionView.frame = self.bounds;
}

#pragma mark - datas
/// 查询数据
- (void)getDatesAtCurrentMoth {
    NSArray *cache = [[YLCalendarDBManager sharedInstance] searchDatesCurrentMonth];
    if (cache.count > 0) {
        self.actualDates = [NSArray arrayWithArray:cache];
    } else {
        NSArray *tmpDates = [YLDateManager allDatesInThisMonthWithDate:[NSDate date]];// 合成数据
        self.actualDates = [NSArray arrayWithArray:tmpDates];
        [[YLCalendarDBManager sharedInstance] insertDatesMonthUnit:tmpDates]; // 写入数据库
    }
}

/// 刷新collectionView
- (void)reloadData {
    [self getDatesAtCurrentMoth];
    [self.collectionView reloadData];
}

#pragma mark - CollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.cellWidth, self.cellWidth);
}

#pragma mark - CollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    SimpleReusableView *reuseableView = (SimpleReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CALENDAR_SUPPLEMENTARY_IDENTIFIER forIndexPath:indexPath];
//    reuseableView.num = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
//    [reuseableView refreshData];
//    return reuseableView;
//}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger firstdayOffset = [YLDateManager weekdayforFirstDayInMonth:[NSDate date]];//当月1号在item中的偏移位置
    NSUInteger allItems = firstdayOffset + self.actualDates.count;
    //[YLCalendarManager lengthForThisMonthWithDate:[NSDate date]];
    return allItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YLCalendarViewCell *cell = (YLCalendarViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CALENDAR_CELL_IDENTIFIER forIndexPath:indexPath];
    
    NSUInteger firstdayOffset = [YLDateManager weekdayforFirstDayInMonth:[NSDate date]]; //当月1号在item中的偏移位置(1号之前的位置皆为空白）
    if (indexPath.item < firstdayOffset) {
        [cell refreshData:nil];
    } else {
        YLDate *date = self.actualDates[indexPath.item - firstdayOffset];
        YLDate *today = [[YLDate alloc] initWithDate:[NSDate date]];
        BOOL isfuture = date.day > today.day;
        NSDictionary *vmDict = @{
            @"title":[NSString stringWithFormat:@"%ld",date.day],
            @"hidden": @(isfuture),
            @"selected": @(date.day == today.day),
            @"marked":@(date.marked),
        };
        YLCalendarViewCellModel *model = [[YLCalendarViewCellModel alloc] initWithDict:vmDict];
        [cell refreshData:model];
    }
    return cell;
}


@end
