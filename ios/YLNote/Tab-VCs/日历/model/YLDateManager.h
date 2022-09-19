//
//  YLCalendarManager.h
//  YLNote
//
//  Created by tangh on 2022/9/18.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YLDate;

NS_ASSUME_NONNULL_BEGIN

@interface YLDateManager : NSObject

+ (instancetype)sharedInstance;

/// (指定日期做在的月)月初是周几
/// @param date 指定日期
+ (NSInteger)weekdayforFirstDayInMonth:(NSDate *)date;

/// 一个月有多少天
/// @param date 指定日期
+ (NSInteger)lengthForThisMonthWithDate:(NSDate *)date;

/// 一个月内所有的YLDate
/// @param date 指定日期
+ (NSArray<YLDate *> *)allDatesInThisMonthWithDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
