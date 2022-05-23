//
//  YLDomain.h
//  YLNote
//
//  Created by tangh on 2021/8/11.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLObject.h"

NS_ASSUME_NONNULL_BEGIN

/// 域
@interface YLDomain : YLObject
@property(nonatomic,copy)NSString *domainId;
@property(nonatomic,assign)BOOL haveNucleus;

@end

NS_ASSUME_NONNULL_END
