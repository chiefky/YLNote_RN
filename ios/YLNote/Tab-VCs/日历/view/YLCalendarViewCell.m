//
//  YLCalendarViewCell.m
//  YLNote
//
//  Created by yuri on 2017/7/27.
//  Copyright © 2017年 yuri. All rights reserved.
//

#import "YLCalendarViewCell.h"
#import "YLNote-Swift.h"

@interface YLCalendarViewCell()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImageView *markedImageView;

@end

@implementation YLCalendarViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_label];
    self.backgroundView = [[UIView alloc] init];
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (void)setupUI {
    
}

- (void)layoutSubviews {
    // 这个 super 方法也必须要调用，否则 self 的 frame 变化了，但是 contentView 的 frame 却没有变化，导致 self.contentView.center 不对
    [super layoutSubviews];
    [self.label sizeToFit];
    self.label.center = self.contentView.center;
}


- (void)refreshData:(YLCalendarViewCellModel *)model {
    _label.text = model ? model.title : @"";
    [self setNeedsLayout];
    self.markedImageView.hidden = model ? model.hidden : YES;
    self.markedImageView.backgroundColor = model.marked ? [UIColor orangeColor] : [UIColor lightGrayColor];
    self.backgroundView.backgroundColor = model.selected ? [[UIColor alloc] initWithHex:@"#F8F0E1" alpha:1] : [YLTheme main].backColor;
}

- (UIImageView *)markedImageView {
    if (!_markedImageView) {
        _markedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-2.5, self.bounds.size.height-10, 5, 5)];
        [self addSubview:_markedImageView];
        _markedImageView.backgroundColor = [UIColor systemPinkColor];
    }
    return _markedImageView;
}
@end

@interface YLCalendarViewCellModel ()
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) BOOL selected;
@property (nonatomic,assign) BOOL hidden;
@property (nonatomic,assign) BOOL marked;

@end

@implementation YLCalendarViewCellModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.title = dict[@"title"];
        self.selected = [dict[@"selected"] boolValue];
        self.hidden = [dict[@"hidden"] boolValue];
        self.marked = [dict[@"marked"] boolValue];

    }
    return self;
}


@end
