//
//  YLScrollView.h
//  YLNote
//
//  Created by tangh on 2022/5/24.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^YLScrollViewItemSelBlock)(NSInteger);
@interface YLScrollView : UIView

@property (nonatomic,copy) YLScrollViewItemSelBlock selectItemBlock;

@end

NS_ASSUME_NONNULL_END
