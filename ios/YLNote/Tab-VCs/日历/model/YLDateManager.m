//
//  YLDateManager.m
//  YLNote
//
//  Created by tangh on 2022/9/18.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLDateManager.h"
#import <sqlite3.h>
#import "YLDate.h"
#import "YYModel/YYModel.h"

@interface YLDateManager (){
    sqlite3 *_db;
    //    sqlite3 *_db;    // 句柄
}

@end

@implementation YLDateManager

+ (instancetype)sharedInstance {
    static YLDateManager *instance;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        instance = [YLDateManager new];
    });
    return instance;
}

#pragma mark - 获得当前月份第一天星期几
+ (NSInteger)weekdayforFirstDayInMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设置每周的第一天从周几开始,默认为1,从周日开始
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    //若设置从周日开始算起则需要减一,若从周一开始算起则不需要减
    return firstWeekday - 1;
}

#pragma mark - 获取当前月共有多少天
+ (NSInteger)lengthForThisMonthWithDate:(NSDate *)date{
    NSRange monthUnitRange = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return monthUnitRange.length;
}

/// date所在自然月内的所有YLDate
/// @param date 指定日期
+ (NSArray<YLDate *> *)allDatesInThisMonthWithDate:(NSDate *)date {
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange monthUnitRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    NSInteger daysCount = monthUnitRange.length; // 1个月内天数
    
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *currentDate = [calendar dateFromComponents:comp]; // 月初1号
    for (int i = 0; i < daysCount; i++) {
        YLDate *yl_date = [[YLDate alloc]initWithDate:currentDate];
        [array addObject:yl_date];
        NSDateComponents *dayComponent = [NSDateComponents new];
        dayComponent.day = 1;
        currentDate = [calendar dateByAddingComponents:dayComponent toDate:currentDate options:0];// currentDate+1天
    }
    return array;
    
}

#pragma mark - sqlite 数据持久化（已废弃，留做以后参考用）
- (BOOL)isExistTable:(NSString *)tablename{
    const char *sql = "SELECT count(*) FROM Calendar WHERE type='table' AND name = 'c_days'";
    char *errMsg = NULL;
        
    int result = sqlite3_exec(_db, sql, NULL, NULL, &errMsg);
    if (result) {
        
    }
    return NO;
}

// 插入数据
- (void)insertDatas:(NSArray<YLDate*>*)datas {
    // _db是数据库的句柄,即数据库的象征,如果对数据库进行增删改查,就得操作这个示例
    
    // 获取数据库文件的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [docPath stringByAppendingPathComponent:@"Calendar.sqlite"];
    NSLog(@"fileNamePath = %@",fileName);
    // 将 OC 字符串转换为 C 语言的字符串
    const char *cFileName = fileName.UTF8String;
    
    // 打开数据库文件(如果数据库文件不存在,那么该函数会自动创建数据库文件)
    int db_result = sqlite3_open(cFileName, &_db);
    if (db_result != SQLITE_OK) {  // 打开失败
        NSLog(@"打开数据库失败");
        return;
    }

    const char *sql = "CREATE TABLE IF NOT EXISTS c_days (id integer PRIMARY KEY,year integer NOT NULL,month integer NOT NULL,day integer NOT NULL,weekday integer NOT NULL,date double NOT NULL,marked integer NOT NULL);";
    char *tb_errMsg = NULL;
    int tb_result = sqlite3_exec(_db, sql, NULL, NULL, &tb_errMsg);
    if (tb_result == SQLITE_OK) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
        printf("创表失败---%s----%s---%d",tb_errMsg,__FILE__,__LINE__);
    }
    
    for (int i = 0; i < datas.count; i++) {
        YLDate *calendar = datas[i];
        // 拼接 sql 语句
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO c_days (id,year,month,day,weekday,date,marked) VALUES ('%f','%ld','%ld','%ld','%ld','%f','%d');",calendar.date,(long)calendar.year,(long)calendar.month,(long)calendar.day,(long)calendar.weekday,calendar.date,calendar.marked];
        
        // 执行 sql 语句
        char *insert_errMsg = NULL;
        int insert_result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &insert_errMsg);
        
        if (insert_result == SQLITE_OK) {
            NSLog(@"插入数据成功 - %f",calendar.date);
        } else {
            NSLog(@"插入数据失败 - %s",insert_errMsg);
            
        }
    }

}

/// 修改
- (BOOL)updateTodaySuccess {
    NSTimeInterval today = [NSDate date].timeIntervalSince1970;
    NSString *sql = [NSString stringWithFormat:@"UPDATE c_days SET marked = '%d' WHERE id = '%f'", 1, today];
    int reslut = sqlite3_exec(_db, sql.UTF8String, nil, nil, nil);
    if (reslut == SQLITE_OK)  {
        NSLog(@"更新数据成功");
        return YES;
    } else   {
        NSLog(@"更新数据失败，错误码:%d", reslut);
        return NO;
    }

}

@end
