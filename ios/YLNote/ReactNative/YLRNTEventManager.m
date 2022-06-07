//
//  YLRNTEventManager.m
//  YLNote
//
//  Created by tangh on 2022/5/24.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLRNTEventManager.h"
#import <React/RCTBridgeModule.h>


@interface YLRNTEventManager ()<RCTBridgeModule>

@end

@implementation YLRNTEventManager
RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents {
  return @[@"selectItem"]; //这里返回的将是你要发送的消息名的数组。
}

- (void)startObserving {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(executeEventInternal:)
                                               name:@"selectItem"
                                             object:nil];
}

- (void)stopObserving {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)executeEventInternal:(NSNotification *)notification {
  [self sendEventWithName:@"selectItem"
                     body:notification.userInfo];
}

+ (void)postEventWithName:(NSString *)name parameter:(NSDictionary *)parameter{
  [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                      object:self
                                                    userInfo:parameter];
}

@end
