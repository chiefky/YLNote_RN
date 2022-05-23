//
//  YLDemoAutoReleaseViewController.m
//  YLNote
//
//  Created by tangh on 2021/4/9.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLDemoAutoReleaseViewController.h"
#import "YLPerson.h"

@interface YLDemoAutoReleaseViewController ()

@property(nonatomic,strong) YLPerson *person;

@end

@implementation YLDemoAutoReleaseViewController
- (void)dealloc {
    NSLog(@"%s:%ld",__FUNCTION__,CFGetRetainCount((__bridge CFTypeRef)self.person));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%s:%ld",__FUNCTION__,CFGetRetainCount((__bridge CFTypeRef)self.person));
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s:%ld",__FUNCTION__,CFGetRetainCount((__bridge CFTypeRef)self.person));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSLog(@"%s:%ld",__FUNCTION__,CFGetRetainCount((__bridge CFTypeRef)self.person));
}

- (YLPerson *)person {
    if (!_person) {
        _person = [[YLPerson alloc] init];
    }
    return _person;
}
@end
