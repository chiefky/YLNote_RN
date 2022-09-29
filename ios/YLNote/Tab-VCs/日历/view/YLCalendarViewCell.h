//
//  YLCalendarViewCell.h
//  YLNote
//
//  Created by yuri on 2017/7/27.
//  Copyright © 2017年 yuri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLCalendarViewCellModel : NSObject
@property (nonatomic,copy,readonly) NSString *title;
@property (nonatomic,assign,readonly) BOOL hidden;
@property (nonatomic,assign,readonly) BOOL marked;
@property (nonatomic,assign,readonly) BOOL selected;


- (instancetype)initWithDict:(NSDictionary *)dict;
@end

@interface YLCalendarViewCell : UICollectionViewCell

- (void)refreshData:(YLCalendarViewCellModel *)model;


@end

