//
//  YLImageView.h
//  YLNote
//
//  Created by tangh on 2022/2/23.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLImageView : UIImageView
@property(readonly,nonatomic,strong) UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
