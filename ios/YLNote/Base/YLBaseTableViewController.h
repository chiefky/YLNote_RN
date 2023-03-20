//
//  YLBaseTableViewController.h
//  YLNote
//
//  Created by tangh on 2021/7/30.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface YLBaseTableViewController : UIViewController

@property(nonatomic,readonly)UITableView *table;

- (NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
