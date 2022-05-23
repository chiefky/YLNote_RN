//
//  YLUser.h
//  YLNote
//
//  Created by tangh on 2021/3/31.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLUser : NSObject
@property (nonatomic, copy) NSString *sessionID;// 问题描述
@property (nonatomic, copy) NSString *name;// 问题描述

@property (nonatomic, copy) NSString *tel;// 问题描述
@property (nonatomic, copy) NSString *gender;// 问题描述
@property (nonatomic, copy) NSString *age;// 问题描述
@property (nonatomic, copy) NSString *address;// 问题描述
@property (nonatomic, copy) NSString *avatarUrl;// 问题描述

@end

NS_ASSUME_NONNULL_END
