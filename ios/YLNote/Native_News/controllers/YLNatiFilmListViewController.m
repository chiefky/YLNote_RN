//
//  YLNatiFilmListViewController.m
//  YLNote
//
//  Created by tangh on 2022/5/24.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLNatiFilmListViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>
#import "YLFimlTableViewCell.h"

static NSString *cellIdentifier = @"kYLFimlTableViewCell";

@interface YLNatiFilmListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy,nonatomic) NSArray *datas;

@end

@implementation YLNatiFilmListViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reqData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 200;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupUI];
}

- (void)setupUI {
    
    [self.view setBackgroundColor: [UIColor whiteColor]];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"YLFimlTableViewCell" ofType:@"nib"];
    if (path) {
        [self.tableView registerNib:[UINib nibWithNibName:@"YLFimlTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    } else {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    }
}

- (void)reqData {
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    [manager GET:@"https://ghibliapi.herokuapp.com/films" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.datas = [NSArray yy_modelArrayWithClass:[YLFilm class] json:responseObject];
        [self.tableView reloadData];
        // 请求成功
        NSLog(@"🍎 success: %@", [NSThread currentThread]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"🍎 failure: %@", [NSThread currentThread]);
    }];

}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[YLFimlTableViewCell class]]) {
        YLFimlTableViewCell *tmpCell = (YLFimlTableViewCell *)cell;
        YLFilm *film = self.datas[indexPath.row];
        [tmpCell setData:film];
    };
    
    return cell;
}


@end
