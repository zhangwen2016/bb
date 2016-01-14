//
//  BMFindMoreTopicDetailTableViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/14.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMFindMoreTopicDetailTableViewController.h"
#import "BMVideoMainTableViewCell.h"
#import "BMRequestManager.h"
#import "BMCommonMethod.h"

#define kTopicDetailAPI @"http://app.meilihuli.com/api/topic/detail/id/28/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"


@interface BMFindMoreTopicDetailTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;
//@property (nonatomic, strong)
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BMFindMoreTopicDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setTableView];
    self.tabBarController.tabBar.hidden = YES;
    [self loadNavView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    NSLog(@"%@", self.parentViewController);
}

//  初始化tableView
- (void)setTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight - 70) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //  注册cell
    [self.tableView registerClass:[BMVideoMainTableViewCell class] forCellReuseIdentifier:@"BMVideoMainTableViewCell"];
}



- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)loadNavView{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"专题详情";
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

- (void) loadData
{
    _dataArr = [NSMutableArray array];
    [BMRequestManager requsetWithUrlString:kTopicDetailAPI parDic:nil Method:GET finish:^(NSData *data)  {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        NSArray *courseList = dataDic[@"courselist"];
        
        //  解析数据
        for (NSDictionary *subDic in courseList) {
            BMVideoMainModel *model = [[BMVideoMainModel alloc] init];
            [model setValuesForKeysWithDictionary:subDic];
            [_dataArr addObject:model];
        }
        [self updateHeaderViewOfTableViewWithDataDic:dataDic];
        [self.tableView reloadData];
    } erro:^(NSError *erro) {
        NSLog(@"erro");
    }];
}


- (void) updateHeaderViewOfTableViewWithDataDic:(NSDictionary *)dataDic
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 230)];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 230)];
    //  把json字符串转化为字典
    NSString *tem = dataDic[@"topic_img"];
    NSData *jsonData = [tem dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *imgDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
   // JSONObject *json = JSONObject.fromObject(jsonStr);
    
    NSLog(@"%@",tem);
    [BMRequestManager downLoadImageView:imgV UrlString:imgDic[@"default"]];
    [headerView addSubview:imgV];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, imgV.bottom + 10, kScreenWidth, 20)];
    titleLable.text = dataDic[@"topic_title"];
    titleLable.font = [UIFont systemFontOfSize:kLargeFont];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLable];
    
    UILabel *introLable = [[UILabel alloc] initWithFrame:CGRectMake(20, titleLable.bottom + 10, kScreenWidth - 40, 20)];
    introLable.numberOfLines = -1;
    introLable.text = dataDic[@"topic_intro"];
    introLable.font = [UIFont systemFontOfSize:kSmallFont];
    introLable.textColor = [UIColor lightGrayColor];
    [headerView addSubview:introLable];
    [BMCommonMethod autoAdjustHeightLabel:introLable labelFontSize:kSmallFont];
    
    headerView.height = introLable.bottom + 10;
    
    self.tableView.tableHeaderView = headerView;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BMVideoMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMVideoMainTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
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
