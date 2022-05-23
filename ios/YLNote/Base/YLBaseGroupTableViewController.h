//
//  YLBaseGroupTableViewController.h
//  YLNote
//
//  Created by tangh on 2021/10/22.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLBaseGroupTableViewController : UIViewController

/// 子类只需重写这个数据源方法
- (NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
