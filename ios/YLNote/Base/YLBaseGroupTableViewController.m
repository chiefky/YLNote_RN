//
//  YLBaseGroupTableViewController.m
//  YLNote
//
//  Created by tangh on 2021/10/22.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLBaseGroupTableViewController.h"
#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>
#import "YLNote-Swift.h"

static NSString *cellIdentifier = @"kYLBaseTableViewCell";
static NSString *headerIdentifier = @"kYLGroupNormalHeaderView";

@interface YLBaseGroupTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *table;

@property (nonatomic,copy) NSArray<YLNoteGroup *> *groupsData;


@end

@implementation YLBaseGroupTableViewController

- (void)setupUI {
    self.table.delegate = self;
    self.table.dataSource = self;

    NSString *headerPath = [[NSBundle mainBundle] pathForResource:@"YLGroupNormalHeaderView" ofType:@"nib"];
    if (headerPath) {
        [self.table registerNib:[UINib nibWithNibName:@"YLGroupNormalHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:headerIdentifier];
    } else {
        [self.table registerClass:[YLGroupNormalHeaderView class] forHeaderFooterViewReuseIdentifier:headerIdentifier];
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"YLQuestionTableViewCell" ofType:@"nib"];
    if (path) {
        [self.table registerNib:[UINib nibWithNibName:@"YLQuestionTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    } else {
        [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
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
- (void)clickGroupAction:(UIButton *)sender {
    YLNoteGroup *sectionData = self.groupsData[sender.tag - 1000];
    BOOL groupStatus = sectionData.unfoldStatus;
    if(!groupStatus){
        sectionData.unfoldStatus = YES;
    } else {
        sectionData.unfoldStatus = NO;
    }
    //刷新当前的分组
    NSIndexSet * set=[[NSIndexSet alloc] initWithIndex:sender.tag - 1000];
    [self.table reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - datasource Protocol
- (void)doFunctionWith:(NSString *)name parameter:(id)parameter {
    NSString *funcName = [NSString stringWithFormat:@"test_%@",name];
    SEL selector = NSSelectorFromString(funcName);
    
    //检查是否有"myMethod"这个名称的方法
    if ([self respondsToSelector:selector]) {
        if (!self) { return; }
        if ([name containsString:@":"]) {
            IMP imp = [self methodForSelector:selector];
            CGRect (*func)(id, SEL, id, id) = (void *)imp;
            CGRect result = self ?
            func(self, selector, @"2", @"3") : CGRectZero;
            NSLog(@"result:: %@",NSStringFromCGRect(result));
        } else {
            IMP imp = [self methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(self, selector);
        }
    }
}

#pragma mark - table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *tmpHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if ([tmpHeader isKindOfClass:[YLGroupNormalHeaderView class]]) {
        YLGroupNormalHeaderView *header = (YLGroupNormalHeaderView *)tmpHeader;
        YLNoteGroup *groupData = self.groupsData[section];
        header.title = groupData.title;
        return header;
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupsData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.groupsData.count > section) {
        YLNoteGroup *groupData = self.groupsData[section];
        NSArray *rowsData = groupData.questions;
        return [rowsData isKindOfClass:[NSArray class]] ? rowsData.count : 0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[YLQuestionTableViewCell class]]) {
        YLQuestionTableViewCell *tmpCell = (YLQuestionTableViewCell *)cell;
        YLNoteGroup *groupData = self.groupsData[indexPath.section];
        YLQuestion *cellData = groupData.questions[indexPath.row];
        if (cellData) {
            tmpCell.titleLabel.text = cellData.title;
            tmpCell.subtitle = cellData.subtitle;
            tmpCell.nextPage.hidden = !cellData.showNextPage;
            if (cellData.showArticle) {
                [tmpCell.articleButton setImage:[UIImage imageNamed: @"article"] forState:UIControlStateNormal];
                tmpCell.articleHandler = ^{
                    if (cellData.showNextPage) {
                        [UIWindow pushToArticleVC:cellData];
                    }
                };
            }

        }
    };
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YLNoteGroup *groupData = self.groupsData[indexPath.section];
    YLQuestion *rowData = groupData.questions[indexPath.row];
    
/*
     NSString *funcName = rowData.function;
     SEL selector = NSSelectorFromString(funcName);
    //检查是否有"myMethod"这个名称的方法
    if ([self respondsToSelector:selector]) {
        if (!self) { return; }
        if ([funcName containsString:@":"]) {
            IMP imp = [self methodForSelector:selector];
            CGRect (*func)(id, SEL, id, id) = (void *)imp;
            CGRect result = self ?
            func(self, selector, @"2", @"3") : CGRectZero;
            NSLog(@"result:: %@",NSStringFromCGRect(result));
        } else {
            IMP imp = [self methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(self, selector);
        }
    }
*/
    if (rowData) {
        if (rowData.showNextPage) {
            [UIWindow pushToDemoVCWith:rowData];
        } else {
            NSString *funcName = rowData.function;
            SEL selector = NSSelectorFromString(funcName);
            if ([self respondsToSelector:selector]) {
                [self performSelector:selector];
            }
        }
    }

}

#pragma mark - lazy

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.rowHeight = 44;
        [self.view addSubview:self.table];
        [_table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _table;
}

- (NSArray<YLNoteGroup *> *)groupsData {
    if (!_groupsData) {
        _groupsData = [NSArray array];
        NSData *json = [YLFileManager jsonParseWithLocalFileName: [self fileName]];
        _groupsData = [NSArray yy_modelArrayWithClass:[YLNoteGroup class] json:json];
    }
    
    return _groupsData;

}

- (NSString *)fileName {
    return @"";
}

@end
