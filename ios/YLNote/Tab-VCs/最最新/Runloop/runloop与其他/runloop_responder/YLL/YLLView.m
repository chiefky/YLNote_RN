//
//  YLLView.m
//  YLNote
//
//  Created by tangh on 2023/2/14.
//  Copyright © 2023 tangh. All rights reserved.
//

#import "YLLView.h"

@implementation YLLView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🍀🍀🍀🍀",self,__FUNCTION__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🌺🌺🌺🌺",self,__FUNCTION__);
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🌼🌼🌼🌼",self,__FUNCTION__);
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🌷🌷🌷🌷",self,__FUNCTION__);
    [super touchesEnded:touches withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🌻🌻🌻🌻",self,__FUNCTION__);
    return  [super hitTest:point withEvent:event];
}


@end

@implementation YLLabel


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🍀🍀🍀🍀🍀",self,__FUNCTION__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🌺🌺🌺🌺🌺",self,__FUNCTION__);
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🌼🌼🌼🌼🌼",self,__FUNCTION__);
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🌷🌷🌷🌷🌷",self,__FUNCTION__);
    [super touchesEnded:touches withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"<%p>:  %s 🌻🌻🌻🌻🌻",self,__FUNCTION__);
    return  [super hitTest:point withEvent:event];
}

@end
