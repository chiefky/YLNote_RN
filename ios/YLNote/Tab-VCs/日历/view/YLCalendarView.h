//
//  YLCalendarView.h
//  YLNote
//
//  Created by tangh on 2022/9/18.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLDate;

NS_ASSUME_NONNULL_BEGIN

@interface YLCalendarView : UIView

/// 手动更新界面
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
