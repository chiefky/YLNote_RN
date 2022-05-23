//
//  YLOperationAsync.h
//  YLNote
//
//  Created by tangh on 2022/2/23.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;

typedef NS_ENUM(NSUInteger, YLOperationAsyncSessionResult) {
    YLOperationAsyncSessionResultSuccess,
    YLOperationAsyncSessionResultFailure,
    YLOperationAsyncSessionResultCanceled,
};

NS_ASSUME_NONNULL_BEGIN

@interface YLOperationAsync : NSOperation
@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) NSString *opID;
@property(nonatomic,copy) void(^completionHandler)(YLOperationAsyncSessionResult status, NSError * _Nullable error,NSData * _Nullable imageData);

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest;

@end

NS_ASSUME_NONNULL_END
