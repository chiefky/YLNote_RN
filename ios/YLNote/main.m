//
//  main.m
//  TestDemo
//
//  Created by tangh on 2020/6/28.
//  Copyright © 2020 tangh. All rights reserved.
//

#import "AppDelegate.h"

int main(int argc, char * argv[]) {

    NSLog(@"main start");
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
   
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
