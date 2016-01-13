//
//  BMSearchTeacherViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMSearchTeacherViewController.h"
#import "BMSearchTeacherModel.h"
#import "BMVideoMainTableViewCell.h"
#import "BMVideoTeacherListTableViewCell.h"
#import "BMSearchLiveCollectionViewCell.h"
#import "BMVideoLiveTableViewCell.h"
#import "BMVideoLinkUserListViewController.h"
#import "BMSearchViewController.h"
#define kSearchTeacherAPI @"http://app.meilihuli.com/api/search/index/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"
#define kPost @"course_count=5&keyword=a&teacher_count=5"
@interface BMSearchTeacherViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *teacherArray;
@property (nonatomic, strong) NSMutableArray *liveArray;
@property (nonatomic, strong) NSMutableArray *courseArray;

@end

@implementation BMSearchTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}


// 提供relodata的借口 防止keyString没有数据
- (void)reloadData{
    [self JsonData];
    [self loadTableView];
    
}
- (void)JsonData{
    _teacherArray = [NSMutableArray array];
    _liveArray = [NSMutableArray array];
    _courseArray = [NSMutableArray array];
    NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
    parDic[@"course_count"] = @"5";
    parDic[@"keyword"] = _keyWordString;
    parDic[@"teacher_count"] = @"5";
//    NSLog(@"%@", _keyWordString);
//    NSLog(@"%@", parDic);
    [BMRequestManager requsetWithUrlString:kSearchTeacherAPI parDic:parDic Method:POST finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        
        NSArray *teacherArray = dic[@"data"][@"teacher"];
        for (NSDictionary *oneDic in teacherArray) {
            BMSearchTeacherModel *model = [[BMSearchTeacherModel alloc] init];
            [model setValuesForKeysWithDictionary:oneDic];
            [_teacherArray addObject:model];
        }
        
        NSArray *courseArray = dic[@"data"][@"course"];
        for (NSDictionary *oneDic in courseArray) {
            BMVideoMainModel *model = [[BMVideoMainModel alloc] init];
            [model setValuesForKeysWithDictionary:oneDic];
            [_courseArray addObject:model];
        }
        
        NSArray *liveArray = dic[@"data"][@"live"];
        for (NSDictionary *oneDic in liveArray) {
            BMSearchTeacherModel *model = [[BMSearchTeacherModel alloc] init];
            [model setValuesForKeysWithDictionary:oneDic];
            [_liveArray addObject:model];
        }
        
        if (_liveArray.count == 0 && _teacherArray.count == 0 && _courseArray.count == 0) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 70)];
            imageView.image = [UIImage imageNamed:@"zhaobudao"];
            [self.view addSubview:imageView];
            return;
        }
        [_listTableView reloadData];
    } erro:^(NSError *erro) {
        [BMCommonMethod NoNetWorkInVC:self];
    }];
}

#pragma mark ---- 加载tableView
- (void)loadTableView{
    _listTableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    _listTableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height);
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerClass:[BMVideoMainTableViewCell class] forCellReuseIdentifier:@"BMVideoMainTableViewCell"];
    [_listTableView registerClass:[BMVideoLiveTableViewCell class] forCellReuseIdentifier:@"BMVideoLiveTableViewCell"];
     [_listTableView registerClass:[BMVideoTeacherListTableViewCell class] forCellReuseIdentifier:@"BMVideoTeacherListTableViewCell"];
    [self.view addSubview:_listTableView];
    
}




#pragma mark --- 实现tableVide 的代理方法

// 2或者3分区可能为0
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_liveArray.count == 0 && _courseArray.count == 0 ) {
        return 1;
    }else if (_liveArray.count == 0 || _courseArray.count == 0){
        return 2;
    }
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _teacherArray.count;
    }else if (section == 1){
        return 1;
    }else{
        return _courseArray.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0 && _teacherArray.count != 0) {
        return @"相关用户";
    }else if (section == 1 && _liveArray.count != 0){
        return @"直播教程";
    }else if (section == 2 && _courseArray.count != 0){
        return @"相关教程";
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        BMVideoTeacherListTableViewCell *teacherCell = [tableView dequeueReusableCellWithIdentifier:@"BMVideoTeacherListTableViewCell" forIndexPath:indexPath];
        teacherCell.teacherModel = _teacherArray[indexPath.row];
         return teacherCell;
    }else if(indexPath.section == 1){
        BMVideoLiveTableViewCell *liveCell = [tableView dequeueReusableCellWithIdentifier:@"BMVideoLiveTableViewCell" forIndexPath:indexPath];
        liveCell.liveArray = _liveArray;
        return liveCell;
    }else if (indexPath.section == 2){
        BMVideoMainTableViewCell *mainCell = [tableView dequeueReusableCellWithIdentifier:@"BMVideoMainTableViewCell"  forIndexPath:indexPath];
        mainCell.model = _courseArray[indexPath.row];
        return mainCell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }else if (indexPath.section == 1){
        if (_liveArray.count % 2 == 1) {
            return (_liveArray.count + 1) / 2 * 150 + 20;
        }
        return _liveArray.count / 2 * 150 + 20;
    }else if(indexPath.section == 2){
        return 230;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else if (section == 1){
        return 30;
    }else if(section == 2){
        return 30;
    }
    return 0;
}

// 第一个分区的表尾 button
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0 && _teacherArray.count != 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        view.backgroundColor = [UIColor whiteColor];
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake((view.width - 150) / 2, 0, 150, 30);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:@"查看更多相关用户" forState:(UIControlStateNormal)];
        [button setTitleColor:kPinkColor forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(moreUserClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:button];
        return view;
    }
    return nil;
}

- (void)moreUserClick:(UIButton *)button{
    
    BMSearchViewController *searchVC =(BMSearchViewController *)[self parentViewController];
    searchVC.searchController.searchBar.hidden = YES;
    BMVideoLinkUserListViewController *linkUserVC = [[BMVideoLinkUserListViewController alloc] init];
    linkUserVC.keyWord = _keyWordString;
    [self.navigationController pushViewController:linkUserVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0 && _teacherArray.count != 0) {
        return 30;
    }
    return 0;
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
