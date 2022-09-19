//
//  YLCalendarDBManager.m
//  YLNote
//
//  Created by tangh on 2022/9/19.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLCalendarDBManager.h"
#import <FMDB/FMDB.h>
#import <YYModel/YYModel.h>

#import "YLDate.h"

@interface YLCalendarDBManager (){
    FMDatabase *_db;
}

@property (nonatomic,strong)FMDatabase *db;

@end

@implementation YLCalendarDBManager

+ (instancetype)sharedInstance {
    static YLCalendarDBManager *instance;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        instance = [YLCalendarDBManager new];
    });
    return instance;
}


///初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDataBase];
    }
    return self;
}

///初始化数据库
- (void)initDataBase{
    
    ///library 路径
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    ///数据库路径
    NSString *dbPath = [libPath stringByAppendingString:@"/fb_calendar.db"];
    
    ///创建数据库
    _db = [FMDatabase databaseWithPath:dbPath];
    
    ///打开数据库
    BOOL isOpen = [_db open];
    
    if (!isOpen) {
        NSLog(@"数据库打开失败");
    } else {
        NSString *sql = @"CREATE TABLE IF NOT EXISTS t_dates (d_id text PRIMARY KEY,year integer ,month integer ,day integer ,weekday integer ,date text ,marked integer );";
        BOOL result = [_db executeUpdate:sql];
        if (result) {
            NSLog(@"创建数据库成功 %@",dbPath);
        }
        [_db close];
    }
}





#pragma mark - 增
/// 插入1天
/// @param date yldate
- (void)insertDate:(YLDate *)date {
    
    [self.db open];
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO t_dates (d_id,year,month,day,weekday,date,marked) VALUES ('%@','%ld','%ld','%ld','%ld','%@','%ld');",date.d_id,(long)date.year,(long)date.month,(long)date.day,(long)date.weekday,date.date,(long)date.marked];
    BOOL result = [_db executeUpdate:sqlStr];
    
    if (result) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
    [self.db close];
    
}

/// 插入一个月
/// @param days 月
- (void)insertDatesMonthUnit:(NSArray<YLDate*> *)days {
    [self.db open];

    for (YLDate *date in days) {
        NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO t_dates (d_id,year,month,day,weekday,date,marked) VALUES ('%@','%ld','%ld','%ld','%ld','%@','%ld');",date.d_id,(long)date.year,(long)date.month,(long)date.day,(long)date.weekday,date.date,(long)date.marked];
        BOOL result = [_db executeUpdate:sqlStr];
        if (result) {
            NSLog(@"%@ 插入成功",date.d_id);
        } else {
            NSLog(@"%@ 插入失败",date.d_id);
        }
    }
    [self.db close];
}

#pragma mark - 删

#pragma mark - 改
/// 更新单条数据:标记 marked -> 1
/// @param dateId id
- (BOOL)markedDateWithID:(NSString *)dateId {
    [self.db open];
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE t_dates SET marked = 1 WHERE d_id = '%@'",dateId];
    BOOL result = [self.db executeUpdate:sqlStr];
    if (result) {
        NSLog(@"更新成功");
    } else {
        NSLog(@"更新失败");
    }
    [self.db close];
    return result;
}

#pragma mark - 查
/// 查询某一天
/// @param dateId dateid
- (YLDate *)searchDateWithID:(NSString *)dateId {
    [self.db open];
    
    NSString *sql= [NSString stringWithFormat:@"SELECT * FROM t_dates WHERE d_id = '%@'",dateId];
    FMResultSet *result = [self.db executeQuery:sql];
    if ([result next]) {
        NSDictionary *cache = @{
            @"d_id":[result stringForColumn:@"d_id"],
            @"year":[result stringForColumn:@"year"],
            @"month":[result stringForColumn:@"month"],
            @"day":[result stringForColumn:@"day"],
            @"weekday":[result stringForColumn:@"weekday"],
            @"date":[result stringForColumn:@"date"],
            @"marked":[result stringForColumn:@"marked"],
        };
        YLDate *calemdar = [YLDate yy_modelWithDictionary:cache];
        return calemdar;
    } else {
        return nil;
    }
}

/// 查询当前月
- (NSArray *)searchDatesCurrentMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    return [self searchDatesWithUnitMonth:comp.month year:comp.year];
}

/// 查询某个月
/// @param month x月
/// @param year xx年
- (NSArray *)searchDatesWithUnitMonth:(NSInteger)month year:(NSInteger)year {
    [self.db open];
    NSMutableArray *arr = [NSMutableArray array];
    NSString *sql= [NSString stringWithFormat:@"SELECT * FROM t_dates WHERE month = '%ld' AND year = '%ld';",month,year];
    FMResultSet *result = [self.db executeQuery:sql];
    while ([result next]) {
        NSDictionary *cache = @{
            @"d_id":[result stringForColumn:@"d_id"],
            @"year":[result stringForColumn:@"year"],
            @"month":[result stringForColumn:@"month"],
            @"day":[result stringForColumn:@"day"],
            @"weekday":[result stringForColumn:@"weekday"],
            @"date":[result stringForColumn:@"date"],
            @"marked":[result stringForColumn:@"marked"],
        };
        YLDate *calemdar = [YLDate yy_modelWithDictionary:cache];
        [arr addObject:calemdar];
    }
    
    return [arr copy];;
    
}

@end
