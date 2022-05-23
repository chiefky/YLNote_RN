//
//  YLBaseTableData.m
//  YLNote
//
//  Created by tangh on 2021/10/22.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLBaseTableData.h"
#import "YLFileManager.h"
#import <YYModel/YYModel.h>

@implementation YLBaseTableData

@end

@interface YLBaseTableCellData ()
//@property(nonatomic,copy,readonly) NSString *cd_id;
//@property(nonatomic,copy,readonly) YLQuestion *cd_question;
//@property(nonatomic,copy,readwrite) NSString *funcName;
@end

@implementation YLBaseTableCellData

//+ (instancetype)dataWithTitle:(NSString *)title selector:(NSString *)selector {
//    return [[self alloc] initWithTitle:title subtitle:@"" selector:selector];
//}
//
//- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle selector:(NSString *)selector {
//    _title = title;
//    _funcName = selector;
//    _subtitle = subtitle;
//    
//    return self;
//}
//
//+ (instancetype)dataWithJsonFileName:(NSString *)fileName {
//    return [YLFileManager jsonParseWithLocalFileName:fileName];
//}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"cd_question": [YLQuestion class]};
}


@end

@interface YLBaseTableGroupData ()
@property(nonatomic,copy,readwrite) NSString *title;
@property(nonatomic,copy,readwrite) NSArray<YLBaseTableCellData *> *rowsData;
@end

@implementation YLBaseTableGroupData

+ (instancetype)dataWithTitle:(NSString *)title rows:(nonnull NSArray *)rowsdata {
    return [[self alloc] initWithTitle:title rows:rowsdata];
}

- (instancetype)initWithTitle:(NSString *)title rows:(NSArray *)rowsdata {
    _title = title;
    _rowsData = [NSArray arrayWithArray:rowsdata];
    
    return self;
}


@end
