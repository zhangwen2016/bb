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

@interface BMAnchorRankChildViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *rankDataArr;


@end

@implementation BMAnchorRankChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}

- (void)setRankAPI:(NSString *)rankAPI
{
    _rankAPI = rankAPI;
    [self loadData];
    [self setUpTableView];
}

- (void)loadData
{
    _rankDataArr = [NSMutableArray array];
    
    //  获取荣誉榜和人气主播的信息
    [BMRequestManager requsetWithUrlString:_rankAPI parDic:nil Method:GET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArr = dic[@"data"];

        [self provideInforToDataSorce:_rankDataArr WithArray:dataArr];
        
        [self.tableView reloadData];
        
    } erro:^(NSError *erro) {
        NSLog(@"erro");
    }];

}

- (void)provideInforToDataSorce:(NSMutableArray *)dataArr WithArray:(NSArray *)array
{
    for (NSDictionary *subDic in array) {
        BMAnchorRecommendModel *model = [[BMAnchorRecommendModel alloc] init];
        [model setValuesForKeysWithDictionary:subDic];
        [dataArr addObject:model];
    }
}

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
