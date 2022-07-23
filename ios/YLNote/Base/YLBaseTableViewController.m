//
//  YLBaseTableViewController.m
//  YLNote
//
//  Created by tangh on 2021/7/30.
//  Copyright © 2021 tangh. All rights reserved.
//

#import "YLBaseTableViewController.h"
#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>
#import "YLNote-Swift.h"




@interface YLBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *table;

@property (nonatomic,copy) NSArray<YLQuestion *> *datas;

@end

@implementation YLBaseTableViewController

static NSString *cellIdentifier = @"YLBaseTableViewCell";

- (void)dealloc {
    NSLog(@"%@,%s",[self class],__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"YLQuestionTableViewCell" ofType:@"nib"];
    if (path) {
        [self.table registerNib:[UINib nibWithNibName:@"YLQuestionTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    } else {
        [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[YLQuestionTableViewCell class]]) {
        YLQuestionTableViewCell *tmpCell = (YLQuestionTableViewCell *)cell;
        YLQuestion *cellData = self.datas[indexPath.row];
        if (cellData) {
            NSString *q_id = [cellData.q_id componentsSeparatedByString:@"-"].lastObject;            tmpCell.titleLabel.text = [NSString stringWithFormat:@"%@%@",(q_id ? [q_id stringByAppendingString:@"、 "] : @"🐳 " ),cellData.title];
            tmpCell.subtitle = cellData.subtitle;
            tmpCell.nextPage.hidden = !cellData.showNextPage;
            if (cellData.showArticle) {
                [tmpCell.articleButton setImage:[UIImage imageNamed: @"article"] forState:UIControlStateNormal];
                tmpCell.articleHandler = ^{
                    if (cellData.showArticle) {
                        [UIWindow pushToArticleVC:cellData];
                    }
                };
            }
        };
        
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YLQuestion *cellData = self.datas[indexPath.row];
    if (cellData) {
        if (cellData.showNextPage) {
            [UIWindow pushToDemoVCWith:cellData];
        } else {
            NSString *funcName = cellData.function;
            SEL selector = NSSelectorFromString(funcName);
            if ([self respondsToSelector:selector]) {
                [self performSelector:selector];
            }
        }
    }
}

#pragma mark - lazys
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.rowHeight = 50;
        
    }
    return _table;
}

- (NSArray<YLQuestion *> *)datas {
    if (!_datas) {
        _datas = [NSArray array];
        NSData *json = [YLFileManager jsonParseWithLocalFileName: [self fileName]];
        _datas = [NSArray yy_modelArrayWithClass:[YLQuestion class] json:json];
    }
    
    return _datas;
}

- (NSString *)fileName {
    return @"";
}

@end
