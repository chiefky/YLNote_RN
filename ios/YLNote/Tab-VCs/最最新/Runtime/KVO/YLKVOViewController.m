//
//  YLKVOViewController.m
//  TestDemo
//
//  Created by tangh on 2020/7/15.
//  Copyright © 2020 tangh. All rights reserved.
//

#import "YLKVOViewController.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>
#import "YLDefaultMacro.h"
#import "YLStudent.h"
#import "YLPerson.h"
#import "YLHitTestViewController.h"


@interface YLKVOViewController ()
@property(nonatomic,strong) YLPerson *myPerson;

@end

@implementation YLKVOViewController
- (void)dealloc {
    [self.myPerson removeObserver:self forKeyPath:@"name"];
//    [self.myPerson removeObserver:self forKeyPath:@"name"];
//    [self.myPerson removeObserver:self forKeyPath:@"name"];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addObsetver];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)addObsetver {

    self.myPerson = [[YLPerson alloc] init];
    [self.myPerson addObserver:self forKeyPath:@"name"  options:NSKeyValueObservingOptionNew context:nil];
    [self.myPerson addObserver:self forKeyPath:@"name"  options:NSKeyValueObservingOptionNew context:nil];
//    [self.myPerson addObserver:self forKeyPath:@"name"  options:NSKeyValueObservingOptionNew context:nil];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"🌹🌹🌹 name is changed： %@", [change objectForKey:NSKeyValueChangeNewKey]);
    }
}


#pragma mark - actions
- (void)testAddObserverMulti {
    NSLog(@"clicked -------");
    self.myPerson.name = @"猪头";
}

#pragma mark - cell data
- (NSString *)fileName {
    return @"kvo";
}

@end

