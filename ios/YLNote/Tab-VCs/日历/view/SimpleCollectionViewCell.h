//
//  SimpleCollectionViewCell.h
//  UICollectionViewDemo
//
//  Created by Zachary Zhang on 2017/7/27.
//  Copyright © 2017年 Zachary Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleCollectionCellModel : NSObject
@property (nonatomic,copy,readonly) NSString *title;
@property (nonatomic,assign,readonly) BOOL hidden;
@property (nonatomic,assign,readonly) BOOL marked;
@property (nonatomic,assign,readonly) BOOL selected;


- (instancetype)initWithDict:(NSDictionary *)dict;
@end

@interface SimpleCollectionViewCell : UICollectionViewCell

@property (nonatomic,copy) NSString *num;

- (void)refreshData:(SimpleCollectionCellModel *)model;


@end

