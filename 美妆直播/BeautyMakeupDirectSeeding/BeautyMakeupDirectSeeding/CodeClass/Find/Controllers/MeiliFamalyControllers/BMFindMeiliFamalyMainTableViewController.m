//
//  BMFindMeiliFamalyMainTableViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMFindMeiliFamalyMainTableViewController.h"
#import "BMRequestManager.h"
#import "BMMeiliFamilyCommunityModel.h"
#import "BMFindMeiliFamilyTypeOneTableViewCell.h"
#include "BMFindMeiliFamilyTypeTwoTableViewCell.h"
#import "BMFindMeiliFamilyCheckMoreViewController.h"

#define kCommunityAPI @"http://app.meilihuli.com/api/activity/getlist/count/10/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"

@interface BMFindMeiliFamalyMainTableViewController ()

@property (nonatomic, strong) NSMutableArray *communityArr;//  存储社区解析的数据
@end

@implementation BMFindMeiliFamalyMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[BMFindMeiliFamilyTypeOneTableViewCell class] forCellReuseIdentifier:@"BMFindMeiliFamilyTypeOneTableViewCell"];
    [self.tableView registerClass:[BMFindMeiliFamilyTypeTwoTableViewCell class] forCellReuseIdentifier:@"BMFindMeiliFamilyTypeTwoTableViewCell"];
    [self loadData];
    self.tableView.tableHeaderView = [self headViewForTableView];
}

- (void)loadData
{
    _communityArr = [NSMutableArray array];
    [BMRequestManager requsetWithUrlString:kCommunityAPI parDic:nil Method:GET finish:^(NSData *data)  {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArr = dic[@"data"];
        //  解析数据
        for (NSDictionary *subDic in dataArr) {
            BMMeiliFamilyCommunityModel *model = [[BMMeiliFamilyCommunityModel alloc] init];
            [model setValuesForKeysWithDictionary:subDic];
            [_communityArr addObject:model];
        }
        NSLog(@"%@", _communityArr);
        [self.tableView reloadData];
    } erro:^(NSError *erro) {
        NSLog(@"erro");
    }];

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
//    if (section == 0) {
//        return 0;
//    }
    return _communityArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BMMeiliFamilyCommunityModel *model = _communityArr[indexPath.row];
    if ([model.list_show_type isEqualToString:@"1"]) {
        BMFindMeiliFamilyTypeOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMFindMeiliFamilyTypeOneTableViewCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else{
    
    BMFindMeiliFamilyTypeTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMFindMeiliFamilyTypeTwoTableViewCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    // Configure the cell...
    
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_communityArr.count == 0) {
        return 0;
    }
    BMMeiliFamilyCommunityModel *model = _communityArr[indexPath.row];
    if ([model.list_show_type isEqualToString:@"1"]) {
        return [BMFindMeiliFamilyTypeOneTableViewCell  cellHeightWithModel:model];
    }else
    {
        return [BMFindMeiliFamilyTypeTwoTableViewCell  cellHeightWithModel:model];
    }
    
    return 260;
}

//  表头
- (UIView *) headViewForTableView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200 + 30 + 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *topicLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 20)];
    topicLable.text = @"专题";
    [view addSubview:topicLable];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(kScreenWidth - 100, 10, 90, 20);
    [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [view addSubview:moreBtn];
    
    UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imgBtn.frame = CGRectMake(topicLable.left, moreBtn.bottom + 10, kScreenWidth - 20, 200);
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"annualGoddnessMakeUp" ofType:@"png"];
    [imgBtn setBackgroundImage:[UIImage imageWithContentsOfFile:imgPath] forState:UIControlStateNormal];
    [view addSubview:imgBtn];

    return view;
}

#pragma mark -- 点击查看更多所实现的 方法
- (void)moreBtnAction:(UIButton *)sender
{
    BMFindMeiliFamilyCheckMoreViewController *checkMoreVC = [[BMFindMeiliFamilyCheckMoreViewController alloc] init];
    [self.navigationController pushViewController:checkMoreVC animated:YES];
    
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
