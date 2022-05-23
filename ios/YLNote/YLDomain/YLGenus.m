//
//  YLGenus.m
//  YLNote
//
//  Created by tangh on 2021/8/11.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLGenus.h"

@implementation YLGenus
- (instancetype)initWithId:(NSString *)objectId name:(NSString *)name {
    self = [[[self class] alloc] init];
    if (self) {
        _genusId = objectId;
        self.name = name;
    }
    return self;
}
@end
