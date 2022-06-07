//
//  YLFimlTableViewCell.h
//  YLNote
//
//  Created by tangh on 2022/5/24.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLFilm : NSObject
@property(copy,nonatomic,readonly) NSString *f_id;
@property(copy,nonatomic,readonly) NSString *original_title;

@end

@interface YLFilmTableViewModel : NSObject

@property(copy,nonatomic,readonly) NSString *title;
@property(copy,nonatomic,readonly) NSString *subtitle;
@property(copy,nonatomic,readonly) NSString *content;
@property(copy,nonatomic,readonly) NSString *imageUrl;

- (instancetype)initWithModel:(YLFilm *)ori;

@end


@interface YLFimlTableViewCell : UITableViewCell
- (void)setData:(YLFilm *)data;

@end


NS_ASSUME_NONNULL_END
