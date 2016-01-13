//
//  BMFindMainVC.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/9.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMFindMainVC.h"
#import "BMAnchorTableViewController.h"
#import "BMFindMeiliFamalyMainTableViewController.h"


@interface BMFindMainVC ()

@property (nonatomic, strong) BMAnchorTableViewController *anchorVC;//  主播页面控制器
@property (nonatomic, strong) BMFindMeiliFamalyMainTableViewController *meiliFamilyVC;//  美狸家控制器


@end

@implementation BMFindMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView.topToLeftButton setTitle:@"主播" forState:(UIControlStateNormal)];
    [self.navigationView.topToRightButton setTitle:@"美狸" forState:(UIControlStateNormal)];
    [self addChildVC];
}


- (void)addChildVC
{
    _anchorVC = [[BMAnchorTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    NSLog(@"%@", _anchorVC);
    [self addChildViewController:_anchorVC];
    _anchorVC.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 20 - 50);
    [self.mainScroll addSubview:_anchorVC.tableView];
    
    _meiliFamilyVC = [[BMFindMeiliFamalyMainTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    _meiliFamilyVC.tableView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - 20 - 50);
    [self addChildViewController:_meiliFamilyVC];
    [self.mainScroll addSubview:_meiliFamilyVC.view];
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
