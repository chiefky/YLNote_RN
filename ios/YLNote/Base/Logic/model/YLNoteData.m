//
//  YLNoteData.m
//  YLNote
//
//  Created by tangh on 2021/3/22.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLNoteData.h"
#import <YYModel/YYModel.h>


@implementation YLNoteGroup

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"g_id":@"group_id",
        @"title":@"group_title"
    };
}

+ (NSDictionary *) modelContainerPropertyGenericClass {
    return @{@"questions": [YLQuestion class]};
}

@end


@implementation YLQuestion
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"title":@"q_title",
        @"subtitle":@"q_subtitle"
    };
}

+ (NSDictionary *) modelContainerPropertyGenericClass {
    return @{
        @"demo": [YLQuestionDemo class],
        @"article": [YLQuestionArticle class],
        
    };
}

@end


@implementation YLQuestionArticle

@end


@implementation YLQuestionDemo

@end

