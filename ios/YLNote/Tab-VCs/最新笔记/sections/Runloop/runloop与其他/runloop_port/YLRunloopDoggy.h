//
//  YLRunloopDoggy.h
//  YLNote
//
//  Created by tangh on 2022/2/14.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLRunloopDoggy : NSObject
- (void)launchThreadWithPort:(NSPort *)port;

@end

NS_ASSUME_NONNULL_END
