//
//  YLSpecies.m
//  YLNote
//
//  Created by tangh on 2021/8/11.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLSpecies.h"

@implementation YLSpecies
- (instancetype)initWithId:(NSString *)objectId name:(NSString *)name {
    self = [[[self class] alloc] init];
    if (self) {
        _speciesId = objectId;
        self.name = name;
    }
    return self;
}
@end
