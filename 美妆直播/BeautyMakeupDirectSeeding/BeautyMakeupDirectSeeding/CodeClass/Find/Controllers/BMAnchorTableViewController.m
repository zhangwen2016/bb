//
//  BMAnchorTableViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMAnchorTableViewController.h"
#import "BMRequestManager.h"
#import "BMAnchorRecommendModel.h"
#import "BMPopularAnchorTableViewCell.h"
#import "BMFindAnchorHonerListTableViewCell.h"
#import "BMAnchorFindModel.h"
#import "BMAnchorFindTableViewCell.h"

#import "BMApplyToAnchorViewController.h"
#import "BMAnchorRankMainViewController.h"
#import "BMMicroblogVC.h"

#import "MJRefresh.h"//  下啦刷新的头文件



//  获取荣誉榜和人气主播栏信息
#define kFindAnchorUrl @"http://app.meilihuli.com/api/discover/teacherlist/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"

//  获取第三个分组 发现的内容
#define kFindFindUrl @"http://app.meilihuli.com/api/discover/imglist/count/20/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"
#define kFindFindUrlPart1 @"http://app.meilihuli.com/api/discover/imglist/count/20/page/"
#define kFindFindUrlPart2 @"/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"


@interface BMAnchorTableViewController ()<BMPopularAnchorTableViewCellDelegate, AnchorFindTableViewCellDelegate>

@property (nonatomic, strong)NSMutableArray *honerListArr;//  有两个成员  一个是subscribe 一个是wallet 每个成员是一个arr
@property (nonatomic, strong)NSMutableArray *popularAnchor;//  放第二个分组数据(人气主播拦)数据
@property (nonatomic, strong)NSMutableArray *findArr;//  放发现分组的信息

@property (nonatomic, assign)NSInteger requireIndex;//  刷新需要的数据



@end

@implementation BMAnchorTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //  设置tableView
    [self setUpTableView];
    _requireIndex = 18;
    //  初始化数据
    [self loadData];
    
    
    
        //  下啦刷新
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            //  刷新的时候有了新数据 要把老数据清空 否则会造成数据重复
            _requireIndex = 18;
            [self loadData];
        }];
    
    
//        //  上拉刷新  只响应一次 所以写下面
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
           
            _requireIndex = _requireIndex + 18;
 //           if (_requireIndex > 36) {
   //             _requireIndex = 36;
                [self.tableView.mj_footer endRefreshing];
  //              return ;
 //           }
//            [self getFindInfor];
        }];
    
}

#pragma mark  初始化数据
- (void)loadData
{
    _honerListArr = [NSMutableArray array];
    _popularAnchor = [NSMutableArray array];
    _findArr = [NSMutableArray array];
    [self setUpTableView];
    //  获取荣誉榜和人气主播的信息
    [self getPopularAnchorAndHonerListInfor];
    //  获取发现的信息
    [self getFindInfor];
    
    //  上拉停止刷新
    [self.tableView.mj_header endRefreshing];
}

//  获取荣誉榜和人气主播的信息
- (void)getPopularAnchorAndHonerListInfor
{
    //  获取荣誉榜和人气主播的信息
    [BMRequestManager requsetWithUrlString:kFindAnchorUrl parDic:nil Method:GET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *recommendArr = dic[@"data"][@"recommend"];
        NSArray *subscribeArr = dic[@"data"][@"subscribe"];
        NSArray *walletArr = dic[@"data"][@"wallet"];
        //  给人气主播赋值 (第二section)
        [self provideInforToDataSorce:_popularAnchor WithArray:recommendArr];
        NSMutableArray *subscribeArray = [NSMutableArray array];
        //  第一section的人气排行榜
        [self provideInforToDataSorce:subscribeArray WithArray:subscribeArr];
        [_honerListArr addObject:subscribeArray];
        
        NSMutableArray *walletArray = [NSMutableArray array];
        [self provideInforToDataSorce:walletArray WithArray:walletArr];
        [_honerListArr addObject:walletArray];
        
        [self.tableView reloadData];
        
    } erro:^(NSError *erro) {
        NSLog(@"erro");
    }];
}

//  获取发现的信息
- (void)getFindInfor
{
    NSString *urlStr = [NSString stringWithFormat:@"http://app.meilihuli.com/api/discover/imglist/count/%ld/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8",_requireIndex];
    [BMRequestManager requsetWithUrlString:urlStr parDic:nil Method:GET finish:^(NSData *data)  {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArr = dic[@"data"];
        //  解析数据
//        for (NSDictionary *subDic in dataArr) {
//            BMAnchorFindModel *model = [[BMAnchorFindModel alloc] init];
//            [model setValuesForKeysWithDictionary:subDic];
//            [_findArr addObject:model];
//        }
        
        
        for (int i = (int)_findArr.count; i < _requireIndex; i++) {
            NSDictionary *subDic = dataArr[i];
            BMAnchorFindModel *model = [[BMAnchorFindModel alloc] init];
            [model setValuesForKeysWithDictionary:subDic];
            [_findArr addObject:model];
        }
        if (_requireIndex == 18) {
            [self.tableView reloadData];
        }else{
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    } erro:^(NSError *erro) {
        NSLog(@"erro");
    }];
    
//    //  上拉刷新
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//        _requireIndex = _requireIndex + 18;
//        [self getFindInfor];
//    }];
    
    [self.tableView.mj_footer endRefreshing];

}

- (void)provideInforToDataSorce:(NSMutableArray *)dataArr WithArray:(NSArray *)array
{
    for (NSDictionary *subDic in array) {
        BMAnchorRecommendModel *model = [[BMAnchorRecommendModel alloc] init];
        [model setValuesForKeysWithDictionary:subDic];
        [dataArr addObject:model];
    }
    NSLog(@"%@", dataArr);
}
     
#pragma mark  设置tableView
- (void)setUpTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    //  注册tableView
    [self.tableView registerClass:[BMPopularAnchorTableViewCell class] forCellReuseIdentifier:@"BMPopularAnchorTableViewCell"];
    [self.tableView registerClass:[BMFindAnchorHonerListTableViewCell class] forCellReuseIdentifier:@"BMFindAnchorHonerListTableViewCell"];
    [self.tableView registerClass:[BMAnchorFindTableViewCell class] forCellReuseIdentifier:@"BMAnchorFindTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_honerListArr.count == 0) {
        return 0;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
        default:
            return 0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_honerListArr.count == 0) {
        return nil;
    }
    
    if (indexPath.section == 0) {
        BMFindAnchorHonerListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMFindAnchorHonerListTableViewCell" forIndexPath:indexPath];
        cell.titleLable.font = [UIFont systemFontOfSize:kLargeFont];
        if (indexPath.row == 0) {
            cell.titleLable.text = @"人气排行榜";
            NSString *popularPath = [[NSBundle mainBundle] pathForResource:@"popularImg" ofType:@"png"];
            cell.logoImg.image = [UIImage imageWithContentsOfFile:popularPath];
            cell.dataArr = (NSArray *)_honerListArr[0];
        }else{
            cell.titleLable.text = @"收益排行榜";
            NSString *walletImgPath = [[NSBundle mainBundle] pathForResource:@"walletImg" ofType:@"png"];
            cell.logoImg.image = [UIImage imageWithContentsOfFile:walletImgPath];
            cell.dataArr = _honerListArr[1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 1) {
        BMPopularAnchorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMPopularAnchorTableViewCell" forIndexPath:indexPath];
        [cell.applyAnchor addTarget:self action:@selector(applyAnchorAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.delegate = self;
        cell.dataArr = _popularAnchor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    
    if (indexPath.section == 2) {
        BMAnchorFindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMAnchorFindTableViewCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.index = _requireIndex;
        cell.dataArr = _findArr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

//  返回分组表头 设置标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    lable.font = [UIFont systemFontOfSize:kSmallFont];
    lable.backgroundColor = [UIColor whiteColor];
    switch (section) {
        case 0:
            lable.text = @"  荣誉榜";
            break;
        case 1:
            lable.text = @"  人气主播";
            break;
        case 2:
            lable.text = @"  发现";
            break;
        default:
            break;
    }
    return lable;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 70;
    }
    if (indexPath.section == 1) {
        return 190;
    }
    
    return ((kScreenWidth - 10 * 2 - 10 * 2) / 3 * (_requireIndex / 3)  + 10 * (_requireIndex / 3 + 1)) + 20;
}

#pragma mark  点击cell (只对第一个分组有效)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BMAnchorRankMainViewController *rankVC = [[BMAnchorRankMainViewController alloc] init];
        if (indexPath.row == 0) {
            rankVC.isSubscribe = YES;
        }else
        {
            rankVC.isSubscribe = NO;
        }
        [self.navigationController pushViewController:rankVC animated:YES];

    }
}

#pragma mark  cell里部件要实现的方法
//  点击申请成为主播实现的方法
- (void)applyAnchorAction:(UIButton *)sender
{
    BMApplyToAnchorViewController *appltToAnchorVC = [[BMApplyToAnchorViewController alloc] init];
    [self.navigationController pushViewController:appltToAnchorVC animated:YES];
}


#pragma mark  实现自定义代理方法
- (void)popularAnchorTableViewCellBringModel:(BMAnchorRecommendModel *)model
{
    BMMicroblogVC *microblogVC = [[BMMicroblogVC alloc] init];
    microblogVC.uid = model.uid;
    [self.navigationController pushViewController:microblogVC animated:YES];

}

- (void)anchorFindTableViewCellWithModel:(BMAnchorFindModel *)model
{
    BMMicroblogVC *microblogVC = [[BMMicroblogVC alloc] init];
    microblogVC.uid = model.uid;
    [self.navigationController pushViewController:microblogVC animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
