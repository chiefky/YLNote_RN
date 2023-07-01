//
//  YLThread.m
//  Demo20200420
//
//  Created by tangh on 2020/5/27.
//  Copyright © 2020 tangh. All rights reserved.
//

#import "YLThread.h"

@implementation YLThread
- (void)setName:(NSString *)name {
    [super setName:name];
    NSLog(@"👶🏻：%@ 线程诞生",self.name);

}
- (void)dealloc {
    NSLog(@"💀：%@ 线程销毁， %s",self.name,__FUNCTION__);
}

@end

