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
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
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
