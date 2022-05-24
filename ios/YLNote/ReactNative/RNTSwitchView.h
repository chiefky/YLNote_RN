//
//  RNTSwitchView.h
//  YLNote
//
//  Created by tangh on 2022/5/24.
//  Copyright © 2022 tangh. All rights reserved.
//

#import <React/RCTViewManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNTSwitchView : RCTViewManager
{
  BOOL _clickItemEvent;
}
@property (nonatomic, copy) RCTBubblingEventBlock selectItem;


@end

NS_ASSUME_NONNULL_END
