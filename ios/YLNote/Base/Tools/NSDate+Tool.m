//
//  NSDate+Tool.m
//  YLNote
//
//  Created by tangh on 2021/11/4.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "NSDate+Tool.h"

@implementation NSDate (Tool)

//获取当前时间
+ (NSString *)currentDateString {
    NSDate *date = [NSDate date];
    return [date toStringWithFormat:@"YYYY/MM/dd hh:mm:ss SS "];
}

/// 获取当前时间戳
+ (NSString *)currentTimeIntervalString {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    return [date toTimeIntervalString];
}

/// date 转 string
/// @param dateFormat 设定时间格式
- (NSString *)toStringWithFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [formatter setDateFormat:dateFormat];//设定时间格式,这里可以设置成自己需要的格式,如：@"YYYY/MM/dd hh:mm:ss SS "
    NSString *dateString = [formatter stringFromDate:self];//将时间转化成字符串
    return dateString;

}

- (NSString *)toTimeIntervalString {
    NSTimeInterval time = [self timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

@end
