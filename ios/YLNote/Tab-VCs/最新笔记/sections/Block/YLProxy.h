//
//  YLProxy.h
//  YLNote
//
//  Created by tangh on 2021/7/26.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLProxy : NSProxy

@property(nonatomic,weak) id target;

+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
