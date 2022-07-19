//
//  YLNoteBridgeAPI.h
//  YLNote
//
//  Created by tangh on 2022/5/21.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeDelegate.h>
#import <React/RCTBridge.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLNoteBridgeAPI : RCTBridge
/** 单例 */
+ (YLNoteBridgeAPI *)shareInstance;
@end

@interface YLNoteBridgeHandle : NSObject<RCTBridgeDelegate>

@end


NS_ASSUME_NONNULL_END
