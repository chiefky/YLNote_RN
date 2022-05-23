//
//  YLBaseData.h
//  YLNote
//
//  Created by tangh on 2021/10/22.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLNoteData.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLBaseTableData : NSObject

@end

@interface YLBaseTableCellData : NSObject

@property(nonatomic,copy) NSString *cd_id;
@property(nonatomic,strong) YLQuestion *cd_question;

//@property(nonatomic,copy,readonly) NSString *cd_title;
//@property(nonatomic,copy,readonly) NSString *cd_subtitle;
//@property(nonatomic,copy,readonly) NSString *cd_function;

//
//+ (instancetype)dataWithTitle:(NSString *)title selector:(NSString *)selector;
//+ (instancetype)dataWithJsonFileName:(NSString *)fileName;
//- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle selector:(NSString *)selector;
//
@end

@interface YLBaseTableGroupData : NSObject

@property(nonatomic,copy,readonly) NSString *title;
@property(nonatomic,copy,readonly) NSArray<YLBaseTableCellData *> *rowsData;
+ (instancetype)dataWithTitle:(NSString *)title rows:(NSArray *)rowsdata;

@end

NS_ASSUME_NONNULL_END
