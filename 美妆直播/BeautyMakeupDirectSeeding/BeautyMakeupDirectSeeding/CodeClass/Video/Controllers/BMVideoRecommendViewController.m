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
#define kVideoRecommendApi @"http://app.meilihuli.com/api/videodemand/firstcommend/count/20/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"
@interface BMVideoRecommendViewController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@end

@implementation BMVideoRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
    [self JsonData];
    [self loadSearchBar];

}

#pragma mark -- 加载tableView
- (void)loadTableView{
    
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, self.view.frame.size.height)];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.rowHeight = 230;
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_listTableView registerClass:[BMVideoMainTableViewCell class] forCellReuseIdentifier:@"BMVideoMainTableViewCell"];
    [self.view addSubview:_listTableView];
}

#pragma mark ----- 加载searchBar
- (void)loadSearchBar{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    // BMSearchViewController *searchVC = [[BMSearchViewController alloc] init];
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchBar.placeholder = @"搜索主播/视频";
    searchController.searchResultsUpdater = self;
    searchController.searchBar.tintColor= [UIColor whiteColor];
    searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchController.searchBar.backgroundColor = [UIColor whiteColor];
    [searchController.searchBar sizeToFit];
    [headerView addSubview:searchController.searchBar];
    
  // 在searchController上面覆盖一个透明的button 点击button跳转页面
    UIButton *headerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    headerBtn.frame = headerView.frame;
    [headerBtn addTarget:self action:@selector(headerButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [headerView addSubview:headerBtn];
    
  //  _listTableView.tableHeaderView = searchController.searchBar;
    _listTableView.tableHeaderView = headerView;
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
   // NSLog(@"11");
    BMSearchViewController *searchVC = [[BMSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
}
- (void)headerButtonAction:(UIButton *)button{
    BMSearchViewController *searchVC = [[BMSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}


#pragma mark  ---- 加载数据
- (void)JsonData{
    _dataSourceArray = [NSMutableArray array];
    [BMRequestManager requsetWithUrlString:kVideoRecommendApi parDic:nil Method:GET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *oneDic in dataArray) {
            BMVideoMainModel *model = [[BMVideoMainModel alloc] init];
            [model setValuesForKeysWithDictionary:oneDic];
            [_dataSourceArray addObject:model];
        }
        [_listTableView reloadData];
        
    } erro:^(NSError *erro) {
        NSLog(@"请求失败");
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
