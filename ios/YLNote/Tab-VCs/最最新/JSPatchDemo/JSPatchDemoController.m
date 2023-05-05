//
//  JSPatchDemoController.m
//  YLNote
//
//  Created by tangh on 2023/4/3.
//  Copyright © 2023 tangh. All rights reserved.
//

#import "JSPatchDemoController.h"

@interface JSPatchDemoController ()
@property (nonatomic, strong) UIButton *recordButn;

@end

@implementation JSPatchDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (UIButton *)recordButn {
    if (!_recordButn) {
        _recordButn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recordButn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_recordButn setBackgroundImage:[UIImage imageNamed:@"marked_normal"] forState:UIControlStateNormal];
        [_recordButn setBackgroundImage:[UIImage imageNamed:@"marked_disabled"] forState:UIControlStateDisabled];
        [_recordButn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_recordButn setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        [_recordButn setTitle:@"打卡" forState:UIControlStateNormal];
        [_recordButn setTitle:@"已打卡" forState:UIControlStateDisabled];
//        _recordButn.layer.cornerRadius = 50;
//        _recordButn.layer.masksToBounds = YES;
        [self.view addSubview:_recordButn];
    }
    return _recordButn;
}

- (IBAction)btnClick:(id)sender {
    NSArray *arrTest = @[@"1"];
    @try {
        NSString *strCrash = [arrTest objectAtIndex:2];
        NSLog(@"strCrash %@", strCrash);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Click" message:@"Success" delegate:nil cancelButtonTitle:@"Yes" otherButtonTitles:nil, nil];
        [alert show];
    } @catch (NSException *exception) {
        NSLog(@"exception is %@", exception);
    } @finally {
        NSLog(@"finally");
    }
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
