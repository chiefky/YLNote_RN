//
//  YLCrashHandler.h
//  YLNote
//
//  Created by tangh on 2021/7/26.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//extern void msgTransformError(id self, SEL _cmd);

@interface YLCrashHandler : NSObject

- (void)msgTransformErrorWtihOrigin:(NSString *)orginTarget originSEL:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
