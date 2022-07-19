//
//  YLFimlTableViewCell.m
//  YLNote
//
//  Created by tangh on 2022/5/24.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLFimlTableViewCell.h"
#import <SDWebImage/SDWebImage.h>
#import "YLDefaultMacro.h"
#import "YLNote-Swift.h"
@interface YLFimlTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *r_imageView;
@property (weak, nonatomic) IBOutlet UIView *relContentView;

@end

@implementation YLFimlTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self settingup];
}

- (void)settingup {
    self.relContentView.layer.borderWidth = 1;
    UIColor *borderColor_con = UIColorFromHex(@"0xdddddd");
    self.relContentView.layer.borderColor = borderColor_con.CGColor;

    self.r_imageView.layer.borderWidth = 5;
    UIColor *borderColor_img = UIColorFromHex(@"#B8860B");
    self.r_imageView.layer.borderColor = borderColor_img.CGColor;
}


- (void)setData:(YLFilm *)data {
    
    YLFilmTableViewModel *vmodel = [[YLFilmTableViewModel alloc] initWithModel:data];
    
    self.titleLabel.text = vmodel.title;
    self.subtitleLabel.text = vmodel.subtitle;
    self.contentLabel.text = vmodel.content;
    self.scoreLabel.text = [NSString stringWithFormat:@"%@分",vmodel.score];
    [self.r_imageView sd_setImageWithURL:[NSURL URLWithString:vmodel.imageUrl]];
    self.r_imageView.contentMode = UIViewContentModeScaleAspectFill;

}

- (YLFilmTableViewModel *)viewModeFromOrigin:(YLFilm *)data {
    YLFilmTableViewModel *vm = [[YLFilmTableViewModel alloc] initWithModel:data];
    return vm;
}

@end

@interface YLFilm ()
@property(copy,nonatomic) NSString *f_id;
@property(copy,nonatomic) NSString *title;
@property(copy,nonatomic) NSString *original_title;
@property(copy,nonatomic) NSString *original_title_romanised;
@property(copy,nonatomic) NSString *image;
@property(copy,nonatomic) NSString *movie_banner;
@property(copy,nonatomic) NSString *f_description;
@property(copy,nonatomic) NSString *director;
@property(copy,nonatomic) NSString *producer;
@property(copy,nonatomic) NSString *release_date;
@property(copy,nonatomic) NSString *running_time;
@property(copy,nonatomic) NSString *rt_score;
@property(copy,nonatomic) NSArray *people;
@property(copy,nonatomic) NSString *species;
@property(copy,nonatomic) NSString *locations;
@property(copy,nonatomic) NSString *vehicles;
@property(copy,nonatomic) NSString *url;

@end

@implementation YLFilm
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
        @"f_id":@"id",
        @"f_description":@"description"
    };
}
@end

@interface YLFilmTableViewModel ()
@property(copy,nonatomic) NSString *v_f_id;
@property(copy,nonatomic) NSString *title;
@property(copy,nonatomic) NSString *subtitle;
@property(copy,nonatomic) NSString *content;
@property(copy,nonatomic) NSString *imageUrl;
@property(copy,nonatomic) NSString *score;

@end

@implementation YLFilmTableViewModel

- (instancetype)initWithModel:(YLFilm *)ori {
    self = [super init];
    if (self) {
//        self.v_f_id = ori.f_id;
        self.title = ori.original_title;
        self.subtitle= ori.title;
        self.content = ori.f_description;
        self.imageUrl = ori.image;
        self.score = ori.rt_score;
    }
    return self;
}

@end
