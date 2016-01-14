//
//  BMFindMeiliFamilyCheckMoreViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMFindMeiliFamilyCheckMoreViewController.h"
#import "BMFindMeiliFamilyCheckMoreTableViewCell.h"
#import "BMRequestManager.h"
#import "BMFindMoreTopicDetailTableViewController.h"
#define kCheckMoreAPI @"http://app.meilihuli.com/api/topic/getlist/count/10/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"

@interface BMFindMeiliFamilyCheckMoreViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;// 请求得到的 数据源

@end

@implementation BMFindMeiliFamilyCheckMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
    [self loadData];
    [self loadNavView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)loadNavView{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"美狸专题";
    label.textColor = kPinkColor;
    label.font = [UIFont systemFontOfSize:16];
    label.frame = CGRectMake((navView.width - 200) / 2, 20, 200, 50);
    label.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:label];
    [self.view addSubview:navView];
    
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(10, 35, 20, 20);
    backButton.backgroundColor = kPinkColor;
    [backButton setBackgroundImage:[UIImage imageNamed:@"all_topback.png"] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [navView addSubview:backButton];
}

//  点击返回
- (void)backButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight - 70) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[BMFindMeiliFamilyCheckMoreTableViewCell class] forCellReuseIdentifier:@"BMFindMeiliFamilyCheckMoreTableViewCell"];
}

- (void) loadData
{
    _dataArr = [NSMutableArray array];
    [BMRequestManager requsetWithUrlString:kCheckMoreAPI parDic:nil Method:GET finish:^(NSData *data)  {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArr = dic[@"data"];
        //  解析数据
        for (NSDictionary *subDic in dataArr) {
            BMMeiliFamilyCheckMoreModel *model = [[BMMeiliFamilyCheckMoreModel alloc] init];
            [model setValuesForKeysWithDictionary:subDic];
            [_dataArr addObject:model];
        }
        [self.tableView reloadData];
    } erro:^(NSError *erro) {
        NSLog(@"erro");
    }];
}

#pragma mark  tableView的代理方法
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMFindMeiliFamilyCheckMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMFindMeiliFamilyCheckMoreTableViewCell" forIndexPath:indexPath];
    cell.model = _dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    BMFindMoreTopicDetailTableViewController *topicDetailVC = [[BMFindMoreTopicDetailTableViewController alloc] init];
    NSLog(@"%@", topicDetailVC);
    topicDetailVC.view.backgroundColor = [UIColor whiteColor];
    topicDetailVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);

    [self.navigationController pushViewController:topicDetailVC animated:YES];
    
    
}

//  视图即将消失的时候 显示tabBar
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
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
