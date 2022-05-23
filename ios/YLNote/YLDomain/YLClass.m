//
//  YLClass.m
//  YLNote
//
//  Created by tangh on 2021/8/11.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLClass.h"

@implementation YLClass
- (instancetype)initWithId:(NSString *)objectId name:(NSString *)name {
    self = [[[self class] alloc] init];
    if (self) {
        _ylClassId = objectId;
        self.name = name;
    }
    return self;
}
@end
