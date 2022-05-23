//
//  YLOperationSync.h
//  YLNote
//
//  Created by tangh on 2022/2/21.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLOperationSync : NSOperation
@property(nonatomic,strong) NSString *opID;
@property(nonatomic,strong) NSString *url;
@property(nonatomic,copy) void(^finishBlock)(NSData *data);

@end

NS_ASSUME_NONNULL_END
