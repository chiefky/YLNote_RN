//
//  YLPet.h
//  YLNote
//
//  Created by tangh on 2021/7/15.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLPet : NSObject

@end


@interface YLPet (Language)

@property (nonatomic,copy) NSArray *languages;
@property (nonatomic,copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
