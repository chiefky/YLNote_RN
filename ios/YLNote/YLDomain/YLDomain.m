//
//  YLDomain.m
//  YLNote
//
//  Created by tangh on 2021/8/11.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLDomain.h"

@interface YLDomain ()

@end

@implementation YLDomain

+ (void)initialize {
    NSLog(@"this is YLDomain");
}


- (instancetype)initWithId:(NSString *)objectId name:(NSString *)name {
    self = [[[self class] alloc] init];
    if (self) {
        _domainId = objectId;
        self.name = name;
        
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[YLDomain class]]) {
        if ([self.domainId isEqualToString:((YLDomain *)object).domainId]) {
            return YES;
        }
    }
    return NO;
}

@end
