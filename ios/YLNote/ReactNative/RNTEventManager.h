//
//  RNTEventManager.h
//  YLNote
//
//  Created by tangh on 2022/5/24.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <React/RCTEventEmitter.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNTEventManager : RCTEventEmitter
- (void)sendSelectItem:(NSDictionary *)obj;

@end

NS_ASSUME_NONNULL_END
