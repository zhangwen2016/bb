//
//  BMSearchViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMSearchViewController.h"
#import "BMVideoHotTag.h"
#import "FMDB.h"
#import "BMSearchTeacherViewController.h"
#define kHotTagApi @"http://app.meilihuli.com/api/tag/recommendlist/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"
@interface BMSearchViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UISearchResultsUpdating, UISearchBarDelegate>
@property (nonatomic, strong) UITableView *listTableView;

@property (nonatomic, strong) NSMutableArray *hotTagArray;
@property (nonatomic, strong) NSMutableArray *searchHistoryArray;
@property (nonatomic, strong) NSMutableArray *searchResultArray; // 显示搜索结果的array
@property (nonatomic, strong) BMVideoHotTag *hotTagView;
@property (nonatomic, strong) FMDatabase *dataBase;

@property (nonatomic, strong) BMSearchTeacherViewController *seaTeacherVC;

@end

@implementation BMSearchViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self loadSubView];
    [self JsonData];
    [self readHistoryPath];
}
- (void)loadSubView{
// 搜索拦
    
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 40)];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.hidesNavigationBarDuringPresentation = YES;
    _searchController.dimsBackgroundDuringPresentation = YES;
    _searchController.obscuresBackgroundDuringPresentation = NO;
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.delegate = self;
    _searchController.searchBar.backgroundColor = [UIColor whiteColor];
    _searchController.searchBar.searchBarStyle= UISearchBarStyleMinimal;
    [_searchController.searchBar sizeToFit];
    [searchView addSubview:_searchController.searchBar];
    [self.view addSubview:searchView];
    
    
// 表头view
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *hotTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
    hotTagLabel.text = @"热门标签";
    hotTagLabel.textColor = [UIColor lightGrayColor];
    hotTagLabel.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:hotTagLabel];
    
    _hotTagView = [[BMVideoHotTag alloc] initWithFrame:CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width, headerView.frame.size.height - 20)];
    _hotTagView.currentVC = self;
    [headerView addSubview:_hotTagView];
    
// 加载tableView
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 144) style:(UITableViewStyleGrouped)];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTableView.tableHeaderView = headerView;
    _listTableView.backgroundColor = [UIColor whiteColor];
    [_listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:_listTableView];
    
// 加载跳转的页面
    _seaTeacherVC = [[BMSearchTeacherViewController alloc] init];
    _seaTeacherVC.view.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100);
}

#pragma mark --解析数据
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
}


#pragma mark --- 时刻更新tableList的数据
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString = self.searchController.searchBar.text;
    _searchResultArray = [NSMutableArray arrayWithArray:_searchHistoryArray];
    
    if (searchString.length != 0) {
        NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
        _seaTeacherVC.keyWordString = searchString;
        if (_searchResultArray != nil) {
            [_searchResultArray removeAllObjects];
        }
        _searchResultArray = [NSMutableArray arrayWithArray:[_searchHistoryArray filteredArrayUsingPredicate:preicate]];
    }
    [_listTableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [_seaTeacherVC.view removeFromSuperview];
    return YES;
}




#pragma mark ---searchBar上面的cancel的点击方法 条回去
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    self.tabBarController.tabBar.hidden = NO;
    [searchBar removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//    for(id cc in [searchBar subviews]){
//        if([cc isKindOfClass:[UIButton class]]){
//            UIButton *btn = (UIButton *)cc;
//            [btn setTitle:@"取消"  forState:UIControlStateNormal];
//        }  
//    }
//}

#pragma mark ---- 点击键盘上的search 1 把数据写入数据库 2.并且跳转下一个页面
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 如果没有 就写入
    if (![self JudgeIsConcludeText:searchBar.text]) {
        [_dataBase executeUpdate:@"INSERT INTO searchHistory (searchText) VALUES (?)", searchBar.text];
        [_searchHistoryArray addObject:searchBar.text];
    }
    
    // 先取消searchBar的第一响应者
    if ([_searchController.searchBar isFirstResponder]) {
        [_searchController.searchBar resignFirstResponder];
    }
   // 把收缩老师的页面贴上去
    [self.view addSubview:_seaTeacherVC.view];
    [self addChildViewController:_seaTeacherVC];
    [_seaTeacherVC reloadData];
}
// 判断数据库里面有没有一样的
- (BOOL)JudgeIsConcludeText:(NSString *)text{
    for (NSString *sting in _searchHistoryArray) {
        if ([text isEqualToString:sting]) {
            return YES;
        }
    }
    return NO;
}



#pragma mark--- tableView的代理方法
// 设置分区的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (_searchController.active) {
        if (_searchResultArray.count != 0) {
            return @"历史搜索";
        }
    }else{
        if (_searchHistoryArray.count != 0) {
            return @"历史搜索";
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_searchController.active) {
        return _searchResultArray.count;
    }else{
         return _searchHistoryArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    if (_searchController.active) {
        cell.textLabel.text = _searchResultArray[indexPath.row];
    }else{
        cell.textLabel.text = _searchHistoryArray[indexPath.row];
    }
    return cell;
}


// 点击tableView 把收缩老师的页面贴上去
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    // 分两种情况 收缩的数据 哈有原始数据
    if (_searchController.active) {
        _seaTeacherVC.keyWordString = _searchResultArray[indexPath.row];
    }else{
        _seaTeacherVC.keyWordString = _searchHistoryArray[indexPath.row];
    }
    
    // 先取消searchBar的第一响应者
    if ([_searchController.searchBar isFirstResponder]) {
        [_searchController.searchBar resignFirstResponder];
    }
    // 把收缩老师的页面贴上去
    [self.view addSubview:_seaTeacherVC.view];
    [self addChildViewController:_seaTeacherVC];
    [_seaTeacherVC reloadData];
}



// 实现表尾的Button
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_searchController.active) {
        if (_searchResultArray.count != 0) {
          return [self loadFooterView];
        }
    }else{
        if (_searchHistoryArray.count != 0) {
           return [self loadFooterView];
        }
    }
    return nil;
}
// 加载表尾的button
- (UIView *)loadFooterView{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    footView.backgroundColor = [UIColor whiteColor];
    
    // 清除历史收缩的button
    UIButton *clearButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    clearButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 150) / 2 , 0, 150, 20);
    [clearButton setTitle:@"清除历史搜索" forState:(UIControlStateNormal)];
    [clearButton setTitleColor:kPinkColor forState:(UIControlStateNormal)];
    clearButton.layer.cornerRadius = 10;
    clearButton.layer.borderColor =kPinkColor.CGColor;
    clearButton.layer.borderWidth = 1;
    clearButton.tag = 1000;
    [clearButton addTarget:self action:@selector(clearButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [footView addSubview:clearButton];
    return footView;
}

// 表尾button的点击方法
- (void)clearButtonClick:(UIButton *)button{
    [_dataBase executeUpdate:@"DELETE FROM searchHistory"];
    [_searchHistoryArray removeAllObjects];
    [_searchResultArray removeAllObjects];
    [button removeFromSuperview];
    [_listTableView reloadData];
    
}


#pragma mark --- 得到历史搜索的数据写入数据库
- (void)readHistoryPath{
    _searchHistoryArray = [NSMutableArray array];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"searchHistory.db"];
    _dataBase = [FMDatabase databaseWithPath:path];
    if ([_dataBase open]) {
        // NSLog(@"数据库打开成功");
    }else{
        // NSLog(@"数据库打开失败");
    }
    [_dataBase executeUpdate:@"CREATE TABLE searchHistory (searchText text)"];
    FMResultSet *result = [_dataBase executeQuery:@"SELECT * FROM searchHistory"];
    while ([result next]) {
        NSString *searchText = [result stringForColumn:@"searchText"];
        [_searchHistoryArray addObject:searchText];
    }
}


- (void)viewWillAppear:(BOOL)animated{
    if (_searchController.searchBar.hidden) {
        _searchController.searchBar.hidden = NO;
    }
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
