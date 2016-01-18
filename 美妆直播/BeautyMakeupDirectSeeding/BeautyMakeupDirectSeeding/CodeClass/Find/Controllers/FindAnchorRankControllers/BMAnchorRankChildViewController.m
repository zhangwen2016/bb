//
//  BMAnchorRankChildViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMAnchorRankChildViewController.h"
#import "BMRequestManager.h"
#import "BMAnchorRecommendModel.h"
#import "BMAnchorRankTableViewCell.h"
#import "BMMicroblogVC.h"
#import "MJRefresh.h"//  下啦刷新的头文件

@interface BMAnchorRankChildViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *rankDataArr;

@property (nonatomic, assign) NSInteger requireIndex;//  要加载多少数据


@end

@implementation BMAnchorRankChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _rankDataArr = [NSMutableArray array];
    _requireIndex = 30;
    [self loadData];
    [self setUpTableView];

}

- (void)setRankAPIPart2:(NSString *)rankAPIPart2
{
    _rankAPIPart2 = rankAPIPart2;
    [self loadData];
    [self setUpTableView];
    
    //  下啦刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        //  刷新的时候有了新数据 要把老数据清空 否则会造成数据重复
        //[_rankDataArr removeAllObjects];
        _requireIndex = 30;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
    
    //  上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        _requireIndex = _requireIndex + 30;
//        if (_requireIndex > 100) {
//            [self.tableView.mj_footer endRefreshing];
//        }
        [self loadData];
    }];
    
}

- (void)loadData
{
    if (_requireIndex >= 30) {
        [_rankDataArr removeAllObjects];
    }
    
    NSString *rankApi = [NSString stringWithFormat:@"%@%ld%@", _rankAPIPart1, _requireIndex,_rankAPIPart2];
    
    
    //  获取荣誉榜和人气主播的信息
    [BMRequestManager requsetWithUrlString:rankApi parDic:nil Method:GET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArr = dic[@"data"];

        if (_requireIndex > 0) {
        
        for (NSDictionary *subDic in dataArr) {
            BMAnchorRecommendModel *model = [[BMAnchorRecommendModel alloc] init];
            [model setValuesForKeysWithDictionary:subDic];
            [_rankDataArr addObject:model];

        }
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
        
//        for (int i = (int)(_requireIndex - 30); i < _requireIndex; i++) {
//            BMAnchorRecommendModel *model = [[BMAnchorRecommendModel alloc] init];
//            [model setValuesForKeysWithDictionary:dataArr[i]];
//            [_rankDataArr addObject:model];
//        }
//            [self.tableView reloadData];
        }
  
    } erro:^(NSError *erro) {
        NSLog(@"erro");
    }];
    
  
    
   
}

//- (void)provideInforToDataSorce:(NSMutableArray *)dataArr WithArray:(NSArray *)array
//{
//    for (NSDictionary *subDic in array) {
//        BMAnchorRecommendModel *model = [[BMAnchorRecommendModel alloc] init];
//        [model setValuesForKeysWithDictionary:subDic];
//        [dataArr addObject:model];
//    }
//}

#pragma mark  设置tableView
- (void)setUpTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //  注册tableView
    [self.tableView registerClass:[BMAnchorRankTableViewCell class] forCellReuseIdentifier:@"BMAnchorRankTableViewCell"];
}

#pragma mark  tableView的代理方法
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rankDataArr.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMAnchorRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMAnchorRankTableViewCell" forIndexPath:indexPath];
    cell.model = _rankDataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMMicroblogVC *microblogVC = [[BMMicroblogVC alloc] init];
    BMAnchorRecommendModel *model = _rankDataArr[indexPath.row];
    microblogVC.uid = model.uid;
    [self.navigationController pushViewController:microblogVC animated:YES];
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
