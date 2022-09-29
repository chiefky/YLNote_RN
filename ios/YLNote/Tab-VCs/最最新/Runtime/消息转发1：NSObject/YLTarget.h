//
//  YLTarget.h
//  YLNote
//
//  Created by tangh on 2021/7/26.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface YLTarget : NSObject

@property(nonatomic,weak,readonly) id realTarget;

+ (instancetype)targetWithRealTarget:(id)realTarget;
- (instancetype)initWithRealTarget:(id)realTarget;

@end

NS_ASSUME_NONNULL_END
