//
//  YLLGestureRecognizer.m
//  YLNote
//
//  Created by tangh on 2023/2/14.
//  Copyright © 2023 tangh. All rights reserved.
//

#import "YLLGestureRecognizer.h"

@implementation YLLGestureRecognizer

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"begin <%p>:  %s 👘👘👘👘",self,__FUNCTION__);
    [super touchesBegan:touches withEvent:event];
    NSLog(@"end <%p>:  %s 👘👘👘👘",self,__FUNCTION__);}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"begin <%p>:  %s 🍣🍣🍣🍣",self,__FUNCTION__);
    [super touchesMoved:touches withEvent:event];
    NSLog(@"end <%p>:  %s 🍣🍣🍣🍣",self,__FUNCTION__);
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"begin <%p>:  %s 🌸🌸🌸🌸",self,__FUNCTION__);
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"end <%p>:  %s 🌸🌸🌸🌸",self,__FUNCTION__);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"begin <%p>:  %s 🎏🎏🎏🎏",self,__FUNCTION__);
    [super touchesEnded:touches withEvent:event];
    NSLog(@"end <%p>:  %s 🎏🎏🎏🎏",self,__FUNCTION__);
}

@end
