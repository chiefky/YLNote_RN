//
//  YLNMyClass_runtime.h
//  YLNote
//
//  Created by tangh on 2021/6/30.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLNMyClass_runtime : NSObject

@property (nonatomic,copy) NSString *name;
- (void)printName;

@end

@interface YLNMyClass_runtime (MyAddition1)

@property (nonatomic,copy) NSString *categoryName;

- (void)printName;
- (void)printCategoryName;

@end

@interface YLNMyClass_runtime (MyAddition2)

@property (nonatomic,copy) NSString *categoryName;

- (void)printName;
@end


NS_ASSUME_NONNULL_END
