//
//  YLDefaultMacro.h
//  TestDemo
//
//  Created by tangh on 2020/7/1.
//  Copyright © 2020 tangh. All rights reserved.
//

#ifndef YLDefaultMacro_h
#define YLDefaultMacro_h

#define YLSCREEN_BOUNDS  [UIScreen mainScreen].bounds
#define YLSCREEN_SIZE  [UIScreen mainScreen].bounds.size
#define YLSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define YLSCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define UIColorFromHex_A(hexString,a) [[UIColor alloc] initWithHex:hexString alpha:a]
#define UIColorFromHex(hexString) UIColorFromHex_A(hexString,1)


#define UIColorFromRGB(r,g,b,a) [UIColor colorWithRed:(r/255.0) green: (g/255.0) blue:(b/255.0) alpha:(a)/1.0]
#define UIColorFromRGB_A(r,g,b) UIColorFromRGB(r,g,b,1.0)

#endif /* YLDefaultMacro_h */
