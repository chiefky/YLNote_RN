//
//  YLCrashHandler.m
//  YLNote
//
//  Created by tangh on 2021/7/26.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLCrashHandler.h"

@implementation YLCrashHandler

- (void)msgTransformErrorWtihOrigin:(NSString *)orginTarget originSEL:(SEL)selector {
    NSLog(@"CRASH ERROR: %@ -- [%s]", orginTarget, sel_getName(selector));
}

@end
