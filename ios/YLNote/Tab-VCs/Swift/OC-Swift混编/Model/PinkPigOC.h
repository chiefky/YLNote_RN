//
//  PinkPigOC.h
//  YLNote
//
//  Created by tangh on 2022/7/19.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PinkPigOC : NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *gender;
@property(nonatomic,assign) NSInteger age;

- (void)sayHello;

@end

NS_ASSUME_NONNULL_END
