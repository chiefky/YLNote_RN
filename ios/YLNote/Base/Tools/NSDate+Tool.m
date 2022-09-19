//
//  NSDate+Tool.m
//  YLNote
//
//  Created by tangh on 2021/11/4.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "NSDate+Tool.h"
/*
 附：NSDateFormatter格式化参数如下：

 G: 公元时代，例如AD公元
 yy: 年的后2位
 yyyy: 完整年
 MM: 月，显示为1-12
 MMM: 月，显示为英文月份简写,如 Jan
 MMMM: 月，显示为英文月份全称，如 Janualy
 dd: 日，2位数表示，如02
 d: 日，1-2位显示，如 2
 EEE: 简写星期几，如Sun
 EEEE: 全写星期几，如Sunday
 aa: 上下午，AM/PM
 H: 时，24小时制，0-23
 K：时，12小时制，0-11
 m: 分，1-2位
 mm: 分，2位
 s: 秒，1-2位
 ss: 秒，2位
 S：毫秒

 常用日期结构：
 yyyy-MM-dd HH:mm:ss.SSS
 yyyy-MM-dd HH:mm:ss
 yyyy-MM-dd
 MM dd yyyy

 注意：yyyy是小写的；大写的YYYY的意思有些不同——“将这一年中第一周的周日当作今年的第一天”，因此有时结果和yyyy相同，有时就会不同。

 作者：GreenC
 链接：https://www.jianshu.com/p/cb3e9a6bb93c
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

@implementation NSDate (Tool)

//获取当前时间
+ (NSString *)currentDateString {
    NSDate *date = [NSDate date];
    return [date toString];
}

/// 年月日生成YLDate实例的id
- (NSString *)yldate_id {
    return [self toStringWithFormat:@"yyyyMMdd"];
}
/// date 转 string ；默认格式："YYYY/MM/dd hh:mm:ss SS "
- (NSString *)toString {
    return [self toStringWithFormat:@"YYYY/MM/dd hh:mm:ss SS "];
}

/// date 转 string
/// @param dateFormat 指定格式
- (NSString *)toStringWithFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [formatter setDateFormat:dateFormat];//设定时间格式,这里可以设置成自己需要的格式,如：@"YYYY/MM/dd hh:mm:ss SS "
    NSString *dateString = [formatter stringFromDate:self];//将时间转化成字符串
    return dateString;

}

/// timeInterval 转string
- (NSString *)toTimeIntervalString {
    NSTimeInterval time = [self timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

@end
