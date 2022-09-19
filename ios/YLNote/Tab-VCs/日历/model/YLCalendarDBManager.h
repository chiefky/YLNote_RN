//
//  YLCalendarDBManager.h
//  YLNote
//
//  Created by tangh on 2022/9/19.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YLDate;

NS_ASSUME_NONNULL_BEGIN

@interface YLCalendarDBManager : NSObject

+ (instancetype)sharedInstance;

- (void)insertDatesMonthUnit:(NSArray<YLDate*> *)days;

/// 读取 当前月
- (NSArray *)searchDatesCurrentMonth;

/// 按月(单位) 读取
- (NSArray *)searchDatesWithUnitMonth:(NSInteger)month year:(NSInteger)year;

/// 按日（单位）读取
- (YLDate *)searchDateWithID:(NSString *)dateId;

/// 按日（单位）插入数据
- (void)insertDate:(YLDate *)date;

/// 根据ID 更新标记打卡
- (BOOL)markedDateWithID:(NSString *)dateId;

@end

NS_ASSUME_NONNULL_END
