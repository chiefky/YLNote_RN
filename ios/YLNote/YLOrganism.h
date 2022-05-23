//
//  YLOrganism.h
//  YLNote
//
//  Created by tangh on 2021/8/11.
//  Copyright © 2021 tangh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLDomain.h"
#import "YLKindom.h"
#import "YLPhylum.h"
#import "YLClass.h"
#import "YLOrder.h"
#import "YLFamily.h"
#import "YLGenus.h"
#import "YLSpecies.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLOrganism : NSObject

@property(nonatomic,copy)NSString *organismId;
@property(nonatomic,copy)NSString *name;

@property(nonatomic,strong)YLDomain *domain;// 域
@property(nonatomic,strong)YLKindom *kindom;// 界
@property(nonatomic,strong)YLPhylum *phylum;// 门
@property(nonatomic,strong)YLClass *orgClass;// 纲
@property(nonatomic,strong)YLOrder *order;// 目
@property(nonatomic,strong)YLFamily *family; // 科
@property(nonatomic,strong)YLGenus *genus; // 属
@property(nonatomic,strong)YLSpecies *species; // 种

@end

NS_ASSUME_NONNULL_END
