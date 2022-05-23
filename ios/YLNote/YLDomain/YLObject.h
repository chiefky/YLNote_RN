//
//  YLObject.h
//  YLNote
//
//  Created by tangh on 2021/8/11.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLObject : NSObject
@property(nonatomic,copy)NSString *name;

- (instancetype)initWithId:(NSString *)objectId name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
