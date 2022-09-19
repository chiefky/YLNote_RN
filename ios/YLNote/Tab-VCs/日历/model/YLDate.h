//
//  YLDate.h
//  YLNote
//
//  Created by tangh on 2022/9/18.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLDate : NSObject


@property (nonatomic,copy,readonly) NSString *d_id; //  这里记录的格式是"yyyyMMdd"
@property (nonatomic,assign,readonly) NSInteger year;
@property (nonatomic,assign,readonly) NSInteger month;
@property (nonatomic,assign,readonly) NSInteger day;
@property (nonatomic,assign,readonly) NSInteger weekday;
@property (nonatomic,assign,readonly) NSInteger marked;

@property (nonatomic,copy,readonly) NSString *date; // 这里记录的是时间戳（since1970）

- (instancetype)initWithDate:(NSDate *)date;// NSDate-->YLDate

@end

NS_ASSUME_NONNULL_END
