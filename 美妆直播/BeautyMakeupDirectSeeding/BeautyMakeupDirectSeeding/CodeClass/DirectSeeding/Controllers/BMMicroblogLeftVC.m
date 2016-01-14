//
//  BMMicroblogLeftVC.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/14.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMMicroblogLeftVC.h"
#import "BMDirectSeedingFirstCell.h"

@interface BMMicroblogLeftVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BMMicroblogLeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTabelView];
    
}

- (void)addTabelView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[BMDirectSeedingFirstCell class] forCellReuseIdentifier:@"BMDirectSeedingFirstCell"];
    [self.view addSubview:_tableView];
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = [NSArray arrayWithArray:dataArray];
    if (_dataArray != nil) {
        [_tableView reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BMDirectSeedingFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingFirstCell"];
    
    cell.microblogModel = _dataArray[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 280;
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
