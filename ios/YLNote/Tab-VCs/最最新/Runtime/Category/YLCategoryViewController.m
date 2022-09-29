//
//  YLCategoryViewController.m
//  YLNote
//
//  Created by tangh on 2021/6/30.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLCategoryViewController.h"
#import "YLPet.h"

@interface YLCategoryViewController ()

@end

@implementation YLCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    YLPet *buou = [[YLPet alloc] init];
    buou.languages = [NSMutableArray arrayWithObjects:@"chinese", nil];
    buou.name = @"松茸";
    
    YLPet *meiduan = [[YLPet alloc] init];
    meiduan.languages = [NSMutableArray arrayWithObjects:@"English", nil];
    meiduan.name = @"包子";
    NSLog(@"buou:%@,meiduan:%@",buou.name,meiduan.name);

//    [buou.languages addObject:@"mmm"];
    meiduan.name = @"山竹";
    NSLog(@"buou:%@,meiduan:%@",buou.name,meiduan.name);

}


@end
