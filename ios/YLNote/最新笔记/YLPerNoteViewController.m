//
//  YLPerNoteViewController.m
//  YLNote
//
//  Created by tangh on 2021/6/28.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLPerNoteViewController.h"
#import "YLNote-Swift.h"
#import <Masonry/Masonry.h>

@interface YLPerNoteViewController ()<YLQuestionDataProtocol>

@property (nonatomic,strong)UITableView *table;

@property (nonatomic,strong) YLPerNoteQesManager *dataManager;
@property (nonatomic,copy) NSArray<YLNoteGroup *> *sectionDatas;


@end

@implementation YLPerNoteViewController

- (void)setupUI {
    self.title = @"笔记整理";
    self.sectionDatas = self.dataManager.allDatas;
    self.table.delegate = self.dataManager;
    self.table.dataSource = self.dataManager;
    self.dataManager.funcHandler = ^(YLQuestion * question, id prama) {
        NSLog(@"%@",question);
    };

    [self.table registerClass:[YLGroupHeaderView class] forHeaderFooterViewReuseIdentifier:[self.dataManager headerIdentifier]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"YLQuestionTableViewCell" ofType:@"nib"];
    if (path) {
        [self.table registerNib:[UINib nibWithNibName:@"YLQuestionTableViewCell" bundle:nil] forCellReuseIdentifier:[self.dataManager cellIdentifier]];
    } else {
        [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:[self.dataManager cellIdentifier]];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
#pragma mark - 点击分组信息
//- (void)clickGroupAction:(UIButton *)sender {
//    YLNoteGroup *sectionData = self.sectionDatas[sender.tag - 1000];
//    BOOL groupStatus = sectionData.unfoldStatus;
//    if(!groupStatus){
//        sectionData.unfoldStatus = YES;
//    } else {
//        sectionData.unfoldStatus = NO;
//    }
//    //刷新当前的分组
//    NSIndexSet * set=[[NSIndexSet alloc] initWithIndex:sender.tag - 1000];
//    [self.table reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
//}


#pragma mark - datasource Protocol
//- (NSString *)jsonFileName {
//    return @"MyNote";
//}
//
//- (NSString *)cellIdentifier {
//    return @"kMyNote_cell";
//}
//
//- (NSString *)headerIdentifier {
//    return @"kYLGroupHeaderView";
//}

//- (void)doFunctionWith:(NSString *)name parameter:(id)parameter {
//    NSString *funcName = [NSString stringWithFormat:@"test_%@",name];
//    SEL selector = NSSelectorFromString(funcName);
//    
//    //检查是否有"myMethod"这个名称的方法
//    if ([self respondsToSelector:selector]) {
//        if (!self) { return; }
//        if ([name containsString:@":"]) {
//            IMP imp = [self methodForSelector:selector];
//            CGRect (*func)(id, SEL, id, id) = (void *)imp;
//            CGRect result = self ?
//            func(self, selector, @"2", @"3") : CGRectZero;
//            NSLog(@"result:: %@",NSStringFromCGRect(result));
//        } else {
//            IMP imp = [self methodForSelector:selector];
//            void (*func)(id, SEL) = (void *)imp;
//            func(self, selector);
//        }
//    }
//    
//    
//}

#pragma mark - lazy

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:self.table];
        [_table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _table;
}

- (YLPerNoteQesManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[YLPerNoteQesManager alloc] init];
    }
    return _dataManager;
}

@end
