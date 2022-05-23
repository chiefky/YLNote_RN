//
//  YLNoteData.h
//  YLNote
//
//  Created by tangh on 2021/3/22.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YLQuestion,YLQuestionArticle,YLQuestionDemo;

typedef NS_ENUM(NSUInteger, YLDemoVCStyle) {
    YLDemoVCStyle_oc = 0,
    YLDemoVCStyle_swift = 1
};

NS_ASSUME_NONNULL_BEGIN


@interface YLNoteGroup : NSObject

@property (nonatomic, copy) NSString *g_id;
@property (nonatomic, copy) NSString *title; // group名称
@property (nonatomic, assign) BOOL unfoldStatus; // 展开状态 Yes:展开
@property (nonatomic, copy) NSArray<YLQuestion*> *questions;// 

@end

@interface YLQuestion : NSObject
@property (nonatomic, copy) NSString *q_id;
@property (nonatomic, copy) NSString *title;// 问题描述
@property (nonatomic, copy) NSString *subtitle;// 问题描述
@property (nonatomic, assign) BOOL showNextPage; // 点击cell是否显示下一页,YES: push到下一页； NO：响应function函数
@property (nonatomic, assign) BOOL showArticle; // 点击头部icon，是否显示article文章，YES：push到文章页；NO：显示默认底图
@property (nonatomic, strong) YLQuestionDemo *demo; // 问题对应的demo类
@property (nonatomic, strong) YLQuestionArticle *article; // 问题对应的article类
@property (nonatomic, copy) NSString *function; // 函数名

@end


@interface YLQuestionArticle : NSObject
@property (nonatomic, copy) NSString *art_id;
@property (nonatomic, copy) NSString *art_url; // 文章url地址
@property (nonatomic, copy) NSString *art_title; // 文章标题
@property (nonatomic, copy) NSString *art_fileName; // 文件名称

@end


@interface YLQuestionDemo : NSObject
@property (nonatomic, copy) NSString *title; // demo 视图标题
@property (nonatomic, copy) NSString *className; // demo类名
@property (nonatomic, assign) YLDemoVCStyle style; // VC 类型 oc:0 , swift:1
@property (nonatomic, assign) BOOL useXib; // 使用xib

@end



NS_ASSUME_NONNULL_END
