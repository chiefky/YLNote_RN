//
//  YLLButton.m
//  YLNote
//
//  Created by tangh on 2023/2/14.
//  Copyright © 2023 tangh. All rights reserved.
//

#import "YLLButton.h"

@implementation YLLButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🐷🐷🐷🐷,tracking:%@",self,__FUNCTION__, self.tracking ? @"YES":@"NO");
    NSLog(@"🐷 next responder:%@",self.nextResponder);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🐱🐱🐱🐱",self,__FUNCTION__);
    [super touchesMoved:touches withEvent:event];

}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🐶🐶🐶🐶",self,__FUNCTION__);
    [super touchesCancelled:touches withEvent:event];

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🦊🦊🦊🦊 begin,tracking:%@",self,__FUNCTION__, self.tracking ? @"YES":@"NO");
    NSLog(@"🦊 next responder:%@",self.nextResponder);
    [super touchesEnded:touches withEvent:event];

}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🍎",self,__FUNCTION__);
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🍊",self,__FUNCTION__);
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🍌",self,__FUNCTION__);
    [super cancelTrackingWithEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🍐",self,__FUNCTION__);
    [super endTrackingWithTouch:touch withEvent:event];
}

@end
