//
//  YLKVCPerson.h
//  YLNote
//
//  Created by tangh on 2021/12/7.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLKVCPerson : NSObject
- (void)printAllVars;

- (void)setMyValue:(id)value forKey:(NSString *)key;
- (id)myValueforKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
