//
//  YLFilmTabView.h
//  YLNote
//
//  Created by tangh on 2022/5/25.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ YLFilmTabActionBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface YLFilmTabView : UIView

- (instancetype)initWithName:(NSString *)name;

@property (assign, nonatomic) BOOL selected;
@property(copy,nonatomic) YLFilmTabActionBlock tabClickHandler;


- (void)changeThemeColor;

@end

NS_ASSUME_NONNULL_END
