//
//  YLKindom.m
//  YLNote
//
//  Created by tangh on 2021/8/11.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLKindom.h"

@implementation YLKindom
//+ (void)initialize {
//    NSLog(@"this is YLKindom");
//}


- (instancetype)initWithId:(NSString *)objectId name:(NSString *)name {
    self = [[[self class] alloc] init];
    if (self) {
        _kindomId = objectId;
        self.name = name;
    }
    return self;
}
@end
