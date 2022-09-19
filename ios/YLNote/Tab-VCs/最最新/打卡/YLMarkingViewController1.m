//
//  YLMarkingViewController.m
//  YLNote
//
//  Created by tangh on 2022/9/16.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLMarkingViewController.h"
#import "YLNote-Swift.h"

@interface YLMarkingViewController ()

@end

@implementation YLMarkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 27, 27);

    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = share;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)buttonClick:(UIButton *)sender {
    [self mark:^(UIActivityType type, BOOL complete, NSArray * items, NSError * error) {
        NSLog(@"items: %@",items);
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
