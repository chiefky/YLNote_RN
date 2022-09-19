//
//  YLDate.m
//  YLNote
//
//  Created by tangh on 2022/9/18.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLDate.h"
#import "NSDate+Tool.h"

@interface YLDate ()

@property (nonatomic,copy) NSString *d_id;
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) NSInteger weekday;
@property (nonatomic,assign) NSInteger marked;

//@property (nonatomic,strong) NSNumber * year;
//@property (nonatomic,strong) NSNumber * month;
//@property (nonatomic,strong) NSNumber * day;
//@property (nonatomic,strong) NSNumber * weekday;
//@property (nonatomic,strong) NSNumber * marked;
@property (nonatomic,copy) NSString *date;

@end

@implementation YLDate

- (instancetype)initWithDate:(NSDate *)date {
    self = [super init];
    if (self) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:date];
        self.d_id = [date yldate_id];
        self.year = components.year;
        self.month = components.month;
        self.day =  components.day;
        self.weekday = components.weekday;
        self.marked = 0;

        self.date = [date toTimeIntervalString];
    }
    return self;
}


@end
