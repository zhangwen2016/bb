//
//  BMMicroblogVC.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMMicroblogVC.h"
#import "BMMicroblogSectionHeaderView.h"
#import "BMMicroblogOneCell.h"
#import "BMDirectSeedingFirstCell.h"
#import "BMMicroblogModel.h"
#import "BMMicroblogRightVC.h"
#import "BMMicroblogLeftVC.h"

#import "UINavigationBar+Awesome.h"
#define NAVBAR_CHANGE_POINT (-190)


@interface BMMicroblogVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *rightVdataArray;

@property (nonatomic,strong) BMMicroblogSectionHeaderView *headerView;

@property (nonatomic,strong) UIView *tempView;
@property (nonatomic,strong) UIImageView *tempOneImage;
@property (nonatomic,strong) UIImageView *tempTwoImage;

@property (nonatomic,strong) BMMicroblogRightVC *RightVC;
@property (nonatomic,strong) BMMicroblogLeftVC *leftVC;

@property (nonatomic,assign) CGFloat rowHeight;

@end

@implementation BMMicroblogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"all_topback@2x"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftButtonAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightButton;
//    self.navigationController.navigationBar.translucent = YES;
    _rowHeight = 280;
    
    [self addTableView];
    
    [self setUpData];
    
}

// 数据加载
- (void)setUpData
{
    
    NSString *url = [NSString stringWithFormat:@"http://app.meilihuli.com/api/user/info/uid/%@/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8",_model.uid];
    
    // 请求数据
    [BMRequestManager requsetWithUrlString:url parDic:nil Method:GET finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
       
        NSDictionary *oneDic = dic[@"data"];
        BMMicroblogModel *model = [[BMMicroblogModel alloc] init];
        [model setValuesForKeysWithDictionary:oneDic];
        _headerView.model = model;
        self.navigationItem.title = model.nickname;

        
    } erro:^(NSError *erro) {
        NSLog(@"请求失败");
    }];

    
    NSString *oneUrl = [NSString stringWithFormat:@"http://app.meilihuli.com/api/videodemand/personallist/uid/%@/page/1/count/50/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8",_model.uid];
    
    // 请求数据
    [BMRequestManager requsetWithUrlString:oneUrl parDic:nil Method:GET finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *array = dic[@"data"];
        
        _dataArray = [NSMutableArray array];
        for (NSDictionary *twoDic in array) {
            BMDsLiveAndPreviewModel *model = [[BMDsLiveAndPreviewModel alloc] init];
            [model setValuesForKeysWithDictionary:twoDic];
            
            [_dataArray addObject:model];
        }
        
        [_tableView reloadData];
        
    } erro:^(NSError *erro) {
        NSLog(@"请求失败");
    }];

    
    NSString *twoUrl = [NSString stringWithFormat:@"http://app.meilihuli.com/api/album/getimglist/page/1/count/20/uid/%@/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8",_model.uid];
    
    // 请求数据
    [BMRequestManager requsetWithUrlString:twoUrl parDic:nil Method:GET finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *array = dic[@"data"];
        
        _rightVdataArray = [NSMutableArray array];
        for (NSDictionary *twoDic in array) {
            BMMicroblogModel *model = [[BMMicroblogModel alloc] init];
            [model setValuesForKeysWithDictionary:twoDic];
            
            [_rightVdataArray addObject:model];
        }
        
        _RightVC.dataArray = _rightVdataArray;
        
    } erro:^(NSError *erro) {
        NSLog(@"请求失败");
    }];

    
}

- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight + 64) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _headerView = [[BMMicroblogSectionHeaderView alloc] initWithFrame:CGRectMake(0, -240, kScreenWidth, 240)];
    
    _headerView.backgroundColor = [UIColor whiteColor];
    
    [_tableView addSubview:_headerView];
    
    _tableView.contentInset =UIEdgeInsetsMake(240,0, 0,0);

    [_tableView registerClass:[BMDirectSeedingFirstCell class] forCellReuseIdentifier:@"BMDirectSeedingFirstCell"];
    [_tableView registerClass:[BMMicroblogOneCell class] forCellReuseIdentifier:@"BMMicroblogOneCell"];
    
    _RightVC = [[BMMicroblogRightVC alloc] init];
    
    _RightVC.view.frame = CGRectMake(0,45, kScreenWidth, _tableView.height - 304);
    _RightVC.view.backgroundColor = [UIColor redColor];
    
    [_tableView addSubview:_RightVC.view];
    [_tableView sendSubviewToBack:_RightVC.view];
    [self.view addSubview:_tableView];
    
    
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    
    UIColor * color = [UIColor magentaColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    
    
    


    CGRect f = _headerView.background_imageView.frame;
    
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat s = -(240 + yOffset + 64);
    NSLog(@"%f",s);
    
    if (s > 0) {
        f.origin.y = 0 - s;
        f.size.height =  160 + s;
        
        if (s > 64) {
            
            f.origin.x =  0 - (s - 64)/2;
            f.size.width = kScreenWidth + (s - 64);
            
        }else{
            f.origin.x = 0;
            f.size.width =kScreenWidth;
        }
        
    }
            _headerView.visualEffv.frame = f;
            _headerView.background_imageView.frame = f;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    _imageView.frame =CGRectMake(0, -240,self.tableView.frame.size.width,240);
    
    [super viewWillAppear:YES];
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

#pragma mark UITableViewDatasource

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"header";
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        BMMicroblogOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMMicroblogOneCell"];
        [cell.Dsbutton addTarget:self action:@selector(DsbuttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        _tempOneImage = cell.DsButtonImage;
        _tempTwoImage = cell.pictureButtonImage;
        _tempView = cell.mineDownView;
        
        [cell.pictureButton addTarget:self action:@selector(pictureButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
        
    }else{
        
        BMDirectSeedingFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingFirstCell"];
        cell.microblogModel = _dataArray[indexPath.row - 1];
        return cell;
    }
    
    return nil;
}

// 切换直播按钮
- (void)DsbuttonAction:(UIButton *)sender
{
    _tempOneImage.image = [UIImage imageNamed:@"kanzhibo"];
    _tempTwoImage.image = [UIImage imageNamed:@"qita01"];
    [UIView animateWithDuration:.5 animations:^{
        CGRect newFrame = _tempView.frame;
        newFrame.origin.x = 0;
        _tempView.frame = newFrame;
        
    }];
    _rowHeight = 280;
    [_tableView reloadData];
    [_tableView sendSubviewToBack:_RightVC.view];

    
}

// 切换其他按钮
- (void)pictureButtonAction:(UIButton *)sender
{
    _tempOneImage.image = [UIImage imageNamed:@"kanzhibo01"];
    _tempTwoImage.image = [UIImage imageNamed:@"qita"];
    
    [UIView animateWithDuration:.5 animations:^{
        CGRect newFrame = _tempView.frame;
        newFrame.origin.x = kScreenWidth/2;
        _tempView.frame = newFrame;
        
    }];
    _rowHeight = 5;
    [_tableView reloadData];
    
    [_tableView bringSubviewToFront:_RightVC.view];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 45;
    }
    
    
    return _rowHeight;
}



#pragma mark ---- 分享按钮
- (void)rightButtonAction:(UIBarButtonItem *)rightButton
{
    
}

#pragma mark ---- 返回按钮

- (void)leftButtonAction:(UIBarButtonItem *)leftButton
{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}


// 分区表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
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
