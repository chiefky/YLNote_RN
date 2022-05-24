//
//  RNTEventManager.m
//  YLNote
//
//  Created by tangh on 2022/5/24.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "RNTEventManager.h"
#import <React/RCTBridgeModule.h>


@interface RNTEventManager ()<RCTBridgeModule>

@end

@implementation RNTEventManager
RCT_EXPORT_MODULE();
//.m文件
+(id)allocWithZone:(NSZone *)zone {
  static RNTEventManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [super allocWithZone:zone];
  });
  return sharedInstance;
}



- (NSArray<NSString *> *)supportedEvents {
    return @[@"selectItem"];
}

- (void)sendSelectItem:(NSDictionary *)obj
{
  [self sendEventWithName:@"selectItem" body:obj];
}
@end
