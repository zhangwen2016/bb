//
//  BMVideoRecommendViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMVideoRecommendViewController.h"
#import "BMVideoMainTableViewCell.h"
#import "BMSearchViewController.h"
#import "BMVideoShowViewController.h"
#import "MJRefresh.h"
@interface BMVideoRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, assign) NSInteger pageCount;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation BMVideoRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTableView];
    [self JsonData];
    [self loadSearchBar];
    [self loadJuHua];
}

- (void)loadJuHua{
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicatorView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 150) / 2, 100, 150, 80);
    _indicatorView.backgroundColor = kPinkColor;
    _indicatorView.alpha = 0.5;
    _indicatorView.layer.cornerRadius =10;
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 65, 120, 10)];
    label.text = @"正在加载";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [_indicatorView addSubview:label];
}

#pragma mark -- 加载tableView
- (void)loadTableView{
    
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, self.view.frame.size.height - 44)];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.rowHeight = 230;
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_listTableView registerClass:[BMVideoMainTableViewCell class] forCellReuseIdentifier:@"BMVideoMainTableViewCell"];
    [self.view addSubview:_listTableView];
    _pageCount = 1;
    _dataSourceArray = [NSMutableArray array];
    
    _listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageCount = 1;
        [self JsonData];
        [self loadJuHua];
    }];
    
    _listTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _pageCount += 1;
        [self JsonData];
        [self loadJuHua];
    }];
}

#pragma mark ----- 加载searchBar
- (void)loadSearchBar{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchBar.placeholder = @"搜索主播/视频";
    [searchController.searchBar sizeToFit];
    [headerView addSubview:searchController.searchBar];
    
  // 在searchController上面覆盖一个透明的button 点击button跳转页面
    UIButton *headerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    headerBtn.frame = headerView.frame;
    [headerBtn addTarget:self action:@selector(headerButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [headerView addSubview:headerBtn];
    _listTableView.tableHeaderView = headerView;
}
- (void)headerButtonAction:(UIButton *)button{
    BMSearchViewController *searchVC = [[BMSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}


#pragma mark  ---- 加载数据
- (void)JsonData{
    if (_pageCount == 1) {
        [_dataSourceArray removeAllObjects];
    }
    NSString *page = [NSString stringWithFormat:@"%ld", (long)_pageCount];
     NSString *VideoRecommendApi =[@"http://app.meilihuli.com/api/videodemand/firstcommend/count/20/page/" stringByAppendingString:[page stringByAppendingString:@"/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"]];
    [BMRequestManager requsetWithUrlString:VideoRecommendApi parDic:nil Method:GET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *oneDic in dataArray) {
            BMVideoMainModel *model = [[BMVideoMainModel alloc] init];
            [model setValuesForKeysWithDictionary:oneDic];
            [_dataSourceArray addObject:model];
        }
        
        [_indicatorView stopAnimating];
        [_listTableView.mj_header endRefreshing];
        [_listTableView.mj_footer endRefreshing];
        [_listTableView reloadData];
        
    } erro:^(NSError *erro) {
        [BMCommonMethod NoNetWorkInVC:self];
    }];
}



#pragma mark --- 实现tableView 的代理方法
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BMVideoMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMVideoMainTableViewCell" forIndexPath:indexPath];
    cell.model = _dataSourceArray[indexPath.row];
    return cell;
};

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BMVideoShowViewController *showVC = [[BMVideoShowViewController alloc] init];
    BMVideoMainModel *model = _dataSourceArray[indexPath.row];
    showVC.source_id = model.source_id;
    [self.navigationController pushViewController:showVC animated:YES];
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
