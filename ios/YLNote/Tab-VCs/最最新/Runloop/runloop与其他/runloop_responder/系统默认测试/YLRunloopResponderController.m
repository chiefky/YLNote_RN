//
//  YLRunloopResponderController.m
//  YLNote
//
//  Created by tangh on 2023/2/9.
//  Copyright © 2023 tangh. All rights reserved.
//

#import "YLRunloopResponderController.h"
#import "YLNote-Swift.h"
#import "YLResponderMyDemoController.h"

typedef NS_ENUM(NSUInteger, ResponderPageType) {
    ResponderPageTypeA = 65,
    ResponderPageTypeB,
    ResponderPageTypeC,
    ResponderPageTypeD
};


@interface YLRunloopResponderController ()

@end

@implementation YLRunloopResponderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)showDemoPage:(ResponderPageType)type {
    YLResponderDemoController *demo = [[YLResponderDemoController alloc] init];
    demo.type = type;
    demo.title = [NSString stringWithFormat:@"ResponderPageType%c",type];
    [self.navigationController pushViewController:demo animated:YES];
}

#pragma mark- func


- (void)testResponder_label {
    [self showDemoPage:ResponderPageTypeA];
}

- (void)testResponder_button {
    [self showDemoPage:ResponderPageTypeB];
}

- (void)testResponder_view {
    [self showDemoPage:ResponderPageTypeC];
}

- (void)testResponder_Gesture {
    [self showDemoPage:ResponderPageTypeD];

}

- (void)testResponder_diy {
    YLResponderMyDemoController *demo = [[YLResponderMyDemoController alloc] init];
    [self.navigationController pushViewController:demo animated:YES];

}

- (NSString *)fileName {
    return @"runloop_responder";
}

@end
