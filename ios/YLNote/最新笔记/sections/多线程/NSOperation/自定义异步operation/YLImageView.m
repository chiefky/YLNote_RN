//
//  YLImageView.m
//  YLNote
//
//  Created by tangh on 2022/2/23.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLImageView.h"
#import <Masonry/Masonry.h>

@interface YLImageView ()

@property(nonatomic,strong) UILabel *titleLabel;

@end

@implementation YLImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
    }];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
