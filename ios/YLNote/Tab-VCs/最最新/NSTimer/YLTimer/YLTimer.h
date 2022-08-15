//
//  YLTimer.h
//  YLNote
//
//  Created by tangh on 2022/8/15.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLTimer : NSObject

- (void)startTimerWithInterval:(NSTimeInterval)inteval;
- (void)stopTimer;
@end

NS_ASSUME_NONNULL_END
