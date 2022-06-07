//
//  RNTSwitchView.m
//  YLNote
//
//  Created by tangh on 2022/5/24.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "RNTSwitchView.h"
#import "RNTSwitchView.h"
#import "YLScrollView.h"
#import "YLRNTEventManager.h"

@implementation RNTSwitchView
RCT_EXPORT_MODULE(RNTSwitch)
RCT_EXPORT_VIEW_PROPERTY(selectItem, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(urlArray, NSArray *)

-(UIView*)view{
  
  YLScrollView* scrollView = [[YLScrollView alloc] init];
//  scrollView.cycleScrollViewStyle = HZCycleScrollViewStyleLoop;
  scrollView.selectItemBlock = ^(NSInteger index) {
    YLRNTEventManager *event = [[YLRNTEventManager alloc] init];
    [event sendSelectItem:@{@"index":[NSNumber numberWithUnsignedInteger:index]}];

  };
  return scrollView;
}



@end
