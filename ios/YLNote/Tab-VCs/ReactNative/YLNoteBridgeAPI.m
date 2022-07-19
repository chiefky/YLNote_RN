//
//  YLNoteBridgeAPI.m
//  YLNote
//
//  Created by tangh on 2022/5/21.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLNoteBridgeAPI.h"

@implementation YLNoteBridgeHandle

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
    NSLog(@"👌1111111111");
    return [NSURL URLWithString:@"http://127.0.0.1:8081/index.bundle?platform=ios"];
#else
    NSLog(@"😯2222222222");
    return [[NSBundle mainBundle] URLForResource:@"index.ios" withExtension:@"jsbundle"];
#endif
    
}
@end

@implementation YLNoteBridgeAPI
static YLNoteBridgeAPI *defaultHandle = nil;
+ (YLNoteBridgeAPI *)shareInstance
{
    @synchronized(self){
        if (defaultHandle == nil) {
            defaultHandle = [[YLNoteBridgeAPI alloc] initWithDelegate:[[YLNoteBridgeHandle alloc]init] launchOptions:nil];
        }
    }
    return defaultHandle;
}
@end
