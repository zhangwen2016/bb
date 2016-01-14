//
//  BMVideoHotViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMVideoHotViewController.h"
#import "BMVideoHotTag.h"
#import "BMAllTagViewController.h"
#import "BMVideoShowViewController.h"
#define kHotApi @"http://app.meilihuli.com/api/videodemand/firsthot/count/20/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"

#define kHotTagApi @"http://app.meilihuli.com/api/tag/recommendlist/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"
@interface BMVideoHotViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) BMVideoHotTag *hotTagView;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *hotTagArray;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, assign) NSInteger pageCount;
@end

@implementation BMVideoHotViewController

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTableView];
    [self JsonData];
    
}

- (void)JsonData{
    _hotTagArray = [NSMutableArray array];
    [BMRequestManager requsetWithUrlString:kHotTagApi parDic:nil Method:GET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *oneDic in dataArray) {
            BMVideoHotTagModel *model = [[BMVideoHotTagModel alloc] init];
            [model setValuesForKeysWithDictionary:oneDic];
            [_hotTagArray addObject:model];
        }
        _hotTagView.sourceArray = _hotTagArray;
        // 根据hotTagArray的count改变 headerView的高度
        _listTableView.tableHeaderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _hotTagView.scrollView.contentSize.height + 20);
        [_listTableView reloadData];
    } erro:^(NSError *erro) {
        nil;
    }];
    
    
    _dataSourceArray = [NSMutableArray array];
    [BMRequestManager requsetWithUrlString:kHotApi parDic:nil Method:GET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *oneDic in dataArray) {
            BMVideoMainModel *model = [[BMVideoMainModel alloc] init];
            [model setValuesForKeysWithDictionary:oneDic];
            [_dataSourceArray addObject:model];
        }
        [_listTableView reloadData];
        
    } erro:^(NSError *erro) {
        [BMCommonMethod NoNetWorkInVC:self];
    }];
}

- (void)loadTableView{
    // 表头view
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *hotTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
    hotTagLabel.text = @"热门标签";
    hotTagLabel.textColor = [UIColor lightGrayColor];
    hotTagLabel.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:hotTagLabel];
    
    _hotTagView = [[BMVideoHotTag alloc] initWithFrame:CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width, headerView.frame.size.height - 20)];
    _hotTagView.currentVC = self;
    [headerView addSubview:_hotTagView];
    
    UIButton *seeMoreButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    seeMoreButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 0, 70, 20);
    [seeMoreButton setTitle:@"查看更多" forState:(UIControlStateNormal)];
    [seeMoreButton setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    seeMoreButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [seeMoreButton addTarget:self action:@selector(seeMoreButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [headerView addSubview:seeMoreButton];
    
    
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, self.view.frame.size.height - 70 - 44)];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.rowHeight = 230;
    _listTableView.tableHeaderView = headerView;
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_listTableView registerClass:[BMVideoMainTableViewCell class] forCellReuseIdentifier:@"BMVideoMainTableViewCell"];
    [self.view addSubview:_listTableView];
    
}

#pragma mark ---- 查看更多的hotTagButton
- (void)seeMoreButton:(UIButton *)button{
    BMAllTagViewController *allTagVC = [[BMAllTagViewController alloc] init];
    [self.navigationController pushViewController:allTagVC animated:YES];
    
}


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
