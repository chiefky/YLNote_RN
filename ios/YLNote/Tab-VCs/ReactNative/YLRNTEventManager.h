//
//  YLRNTEventManager.h
//  YLNote
//
//  Created by tangh on 2022/5/24.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <React/RCTEventEmitter.h>

NS_ASSUME_NONNULL_BEGIN

///即使没有被 JavaScript 调用，原生模块也可以给 JavaScript
///发送事件通知。最好的方法是继承RCTEventEmitter，
///实现suppportEvents方法并调用self sendEventWithName:。
///
/// 原生调用JS方法（发送事件）
@interface YLRNTEventManager : RCTEventEmitter

/// 接收通知的方法，接收到通知后发送事件到RN端。RN端接收到事件后可以进行相应的逻辑处理或界面跳转
+ (void)postEventWithName:(NSString *)name parameter:(NSDictionary *)parameter;

@end

NS_ASSUME_NONNULL_END
