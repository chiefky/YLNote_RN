//
//  NSDate+Tool.h
//  YLNote
//
//  Created by tangh on 2021/11/4.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Tool)

+ (NSString *)currentDateString; // 获取当前时间，格式："YYYY/MM/dd hh:mm:ss SS "

- (NSString *)yldate_id;

- (NSString *)toString; // date 转 string ；默认格式："YYYY/MM/dd hh:mm:ss SS "
- (NSString *)toStringWithFormat:(NSString *)dateFormat; // 普通date转string
- (NSString *)toTimeIntervalString; // 普通date转时间戳string(精确到毫秒)

@end

NS_ASSUME_NONNULL_END
