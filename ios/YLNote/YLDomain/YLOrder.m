//
//  YLOrder.m
//  YLNote
//
//  Created by tangh on 2021/8/11.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLOrder.h"

@implementation YLOrder
-(instancetype)initWithId:(NSString *)objectId name:(NSString *)name {
    self = [[[self class] alloc] init];
    if (self) {
        _orderId = objectId;
        self.name = name;
    }
    return self;
}
@end
