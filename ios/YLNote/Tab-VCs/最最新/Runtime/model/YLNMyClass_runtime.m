//
//  YLNMyClass_runtime.m
//  YLNote
//
//  Created by tangh on 2021/6/30.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLNMyClass_runtime.h"

@implementation YLNMyClass_runtime

- (void)printName
{
    NSLog(@"%@",@"YLNMyClass_runtime");
}

@end

@implementation YLNMyClass_runtime (MyAddition1)

- (void)printName
{
    NSLog(@"%@",@"YLNMyClass_runtime+MyAddition1");
}

- (void)printCategoryName {
    NSLog(@"%@_%@",@"YLNMyClass_runtime+MyAddition1",@"MyAddition1");
}

@end

@implementation YLNMyClass_runtime (MyAddition2)

- (void)printName {
    NSLog(@"%@",@"YLNMyClass_runtime+MyAddition1");
}

@end
