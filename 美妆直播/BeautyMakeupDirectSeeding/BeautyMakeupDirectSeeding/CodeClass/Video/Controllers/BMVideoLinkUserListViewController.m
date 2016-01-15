//
//  BMVideoLinkUserListViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMVideoLinkUserListViewController.h"
#import "BMCommonMethod.h"
#import "BMVideoTeacherListTableViewCell.h"
#import "MJRefresh.h"
#import "BMMicroblogVC.h"
#define kSearchTeachAPi @"http://app.meilihuli.com/api/search/teacher/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"
@interface BMVideoLinkUserListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, assign) NSInteger pageCount;
@end

@implementation BMVideoLinkUserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadNavView];
    [self loadTableView];
    [self JsonData];
    
}
#pragma mark ---- 标题
- (void)loadNavView{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"搜索用户";
    label.textColor = kPinkColor;
    label.font = [UIFont systemFontOfSize:16];
    [BMCommonMethod autoAdjustLeftWidthLabel:label labelFontSize:16];
    label.frame = CGRectMake((navView.width - label.width) / 2, 20, label.width, 50);
    [navView addSubview:label];
    [self.view addSubview:navView];
    
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(10, 35, 20, 20);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [navView addSubview:backButton];
}
- (void)backButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- jsonDATA
- (void)JsonData{
    
    NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
    parDic[@"count"] = @"10";
    parDic[@"keyword"] =_keyWord;
    NSString *page = [NSString stringWithFormat:@"%ld", _pageCount];
    parDic[@"page"] = page;
    [BMRequestManager requsetWithUrlString:kSearchTeachAPi parDic:parDic Method:POST finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *oneDic in dataArray) {
            BMSearchTeacherModel *model = [[BMSearchTeacherModel alloc] init];
            [model setValuesForKeysWithDictionary:oneDic];
            [_dataSourceArray addObject:model];
        }
        [_listTableView.mj_footer endRefreshing];
        [_listTableView reloadData]; 
    } erro:^(NSError *erro) {
        [BMCommonMethod NoNetWorkInVC:self];
    }];
    
}

#pragma mark --- 加载tableView
- (void)loadTableView{
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 70 - 44)];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.rowHeight = 60;
    [_listTableView registerClass:[BMVideoTeacherListTableViewCell class] forCellReuseIdentifier:@"BMVideoTeacherListTableViewCell"];
    [self.view addSubview:_listTableView];
    _dataSourceArray = [NSMutableArray array];
    
    _pageCount = 1;
    _listTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _pageCount += 1;
        [self JsonData];
    }];
    
}

#pragma mark --- tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BMVideoTeacherListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMVideoTeacherListTableViewCell" forIndexPath:indexPath];
    cell.teacherModel = _dataSourceArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BMMicroblogVC *blogVC = [[BMMicroblogVC alloc] init];
    BMSearchTeacherModel *teacherModel = _dataSourceArray[indexPath.row];
    blogVC.uid = teacherModel.uid;
    [self.navigationController pushViewController:blogVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
