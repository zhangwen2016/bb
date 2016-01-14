//
//  BMDirectSeedingLeftVC.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMDirectSeedingLeftVC.h"
#import "BMDirectSeedingSecondCell.h"
#import "BMDirectSeedingCellToOne.h"
#import "BMDirectSeedingFirstCell.h"
#import "BMDirectSeedingThirdCell.h"
#import "BMRequestManager.h"
#import "BMDirectSeedingHeaderView.h"
#import "BMDsLiveAndPreviewModel.h"
#import "BMToBeginPlayTimeView.h"
#import "BMMicroblogVC.h"
#import "BMVideoShowViewController.h"


#define kDirectSeedingUrl @"http://app.meilihuli.com/api/channel/index/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"


@interface BMDirectSeedingLeftVC ()<UITableViewDelegate,UITableViewDataSource,liveButtonDelegate,headerViewDelegate>
@property (nonatomic,strong) UITableView *tableView;

// 保存图片网址的数组
@property (nonatomic,strong) NSMutableArray *imageUrlAarray;

@property (nonatomic,strong) NSString *preview_title;

// 保存直播中的model
@property (nonatomic,strong) NSMutableArray *dsDataArray;

// 保存预告的model
@property (nonatomic,strong) NSMutableArray *todayDataArray;

// 保存关注的model
@property (nonatomic,strong) NSMutableArray *attentionDataArray;

// 保存近期预告的model
@property (nonatomic,strong) NSMutableArray *recentDataArray;

// 弹窗视图
@property (nonatomic,strong) BMToBeginPlayTimeView *timeView;

@property (nonatomic,strong) BMDsLiveAndPreviewModel *tempModel;

@end

@implementation BMDirectSeedingLeftVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imageUrlAarray = [NSMutableArray array];
    _dsDataArray = [NSMutableArray array];
    _todayDataArray = [NSMutableArray array];
    _attentionDataArray = [NSMutableArray array];
    _recentDataArray = [NSMutableArray array];
    
    [self addTableView];
    
    [self setUpData];
}

// 数据处理
- (void)setUpData
{
    // 请求数据
    [BMRequestManager requsetWithUrlString:kDirectSeedingUrl parDic:nil Method:GET finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        // 表头
        NSArray *oneArray = dic[@"data"][@"banner"];
        
        for (NSDictionary *oneDic in oneArray) {
            
            BMDsLiveAndPreviewModel *model = [[BMDsLiveAndPreviewModel alloc] init];
            [model setValuesForKeysWithDictionary:oneDic];
            
            [_imageUrlAarray addObject:model];
            
        }
        BMDirectSeedingHeaderView *headerView = [[BMDirectSeedingHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        headerView.delegate = self;
        
        headerView.ImageUrlArray = _imageUrlAarray;
        _tableView.tableHeaderView = headerView;
        
        // 正在直播的
        NSArray *twoArray = dic[@"data"][@"live"];
        
        for (NSDictionary *twoDic in twoArray) {
            
            BMDsLiveAndPreviewModel *model = [[BMDsLiveAndPreviewModel alloc] init];
            [model setValuesForKeysWithDictionary:twoDic];
            
            [_dsDataArray addObject:model];
            
        }
        
        // 预告
        _preview_title = dic[@"data"][@"preview_title"];
        
        NSArray *threeArray = dic[@"data"][@"preview"];
        
        for (NSDictionary *threeDic in threeArray) {
            
            BMDsLiveAndPreviewModel *model = [[BMDsLiveAndPreviewModel alloc] init];
            [model setValuesForKeysWithDictionary:threeDic];
            [_todayDataArray addObject:model];
            
        }
        
        // 关注
        NSArray *fourArray = dic[@"data"][@"teacher"];
        
        for (NSDictionary *fourDic in fourArray) {
            
            BMDsLiveAndPreviewModel *model = [[BMDsLiveAndPreviewModel alloc] init];
            [model setValuesForKeysWithDictionary:fourDic];
            [_attentionDataArray addObject:model];
            
        }
        
        // 近期预告
        NSArray *fiveArray = dic[@"data"][@"preview_list"];
        for (NSDictionary *fiveDic in fiveArray) {
            
            BMDsLiveAndPreviewModel *model = [[BMDsLiveAndPreviewModel alloc] init];
            [model setValuesForKeysWithDictionary:fiveDic];
            
            [_recentDataArray addObject:model];
            
        }
        
        [_tableView reloadData];
        
    } erro:^(NSError *erro) {
        NSLog(@"请求失败");
    }];
    

    
}


// 添加TableView
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    // 注册cell
    [_tableView registerClass:[BMDirectSeedingCellToOne class] forCellReuseIdentifier:@"BMDirectSeedingCellToOne"];
    
    [_tableView registerClass:[BMDirectSeedingFirstCell class] forCellReuseIdentifier:@"BMDirectSeedingFirstCell"];
    
    [_tableView registerClass:[BMDirectSeedingSecondCell class] forCellReuseIdentifier:@"BMDirectSeedingSecondCell"];
    
    [_tableView registerClass:[BMDirectSeedingThirdCell class] forCellReuseIdentifier:@"BMDirectSeedingThirdCell"];
    
    
    
}

// 返回分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_dsDataArray.count != 0) {
        
        return 4;
    }
    return 3;
}

// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 如果有直播的
    if (_dsDataArray.count != 0) {
        
        if (section == 0) {
            // 直播分区
            return _dsDataArray.count + 1;
            
        }else if (section == 1) {
            // 预告
            return _todayDataArray.count + 1;
            
        }else if (section == 2){
            // 关注
            return _attentionDataArray.count + 1;
            
        }else if (section == 3){
            // 近期预告
            return 2;
        }
        
        
        
        
    }else if (section == 0) {
        // 预告
        return _todayDataArray.count + 1;
        
    }else if (section == 1){
        // 关注
        return _attentionDataArray.count + 1;
        
    }else if (section == 2){
        // 近期预告
        return 2;
    }
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //======================如果有直播
    if (_dsDataArray.count != 0) {
        // 设置各个分区第一个cell
        if (indexPath.row == 0 && indexPath.section == 0) {
            // 设置第一个直播分区
            BMDirectSeedingCellToOne *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingCellToOne"];
            
            cell.imageLabelV.imageView.image = [UIImage imageNamed:@"zhibo02"];
            cell.imageLabelV.label.text = @"正在直播";
            
            if ([_preview_title isEqualToString:@"直播"]) {
                
                cell.imageLabelV.imageView.image = [UIImage imageNamed:@"ye"];
            }
            
            return cell;
            
            
        }else if (indexPath.row == 0 && indexPath.section == 1) {
            // 设置第二个分区
            BMDirectSeedingCellToOne *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingCellToOne"];
            
            cell.imageLabelV.imageView.image = [UIImage imageNamed:@"jin"];
            cell.imageLabelV.label.text = _preview_title;
            
            if ([_preview_title isEqualToString:@"明日预告"]) {
                
                cell.imageLabelV.imageView.image = [UIImage imageNamed:@"ye"];
                
            }
            
            
            
            return cell;
            
        }else if (indexPath.row == 0 && indexPath.section == 2){
            // 设置第三个分区
            
            BMDirectSeedingCellToOne *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingCellToOne"];
            
            cell.imageLabelV.imageView.image = [UIImage imageNamed:@"xiao"];
            cell.imageLabelV.label.text = @"大家都在关注";
            return cell;
        }else if (indexPath.row == 0 && indexPath.section == 3){
            // 设置第四个分区
            
            BMDirectSeedingCellToOne *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingCellToOne"];
            
            cell.imageLabelV.imageView.image = [UIImage imageNamed:@"7"];
            cell.imageLabelV.label.text = @"近期预告";
            return cell;
        }
        
        
        // 设置第一个分区
        if (indexPath.section == 0) {
            BMDirectSeedingFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingFirstCell"];
            
            cell.model = _dsDataArray[indexPath.row -1];
            
            return cell;
            
        }else if (indexPath.section == 1) {
            // 第二个分区
            BMDirectSeedingFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingFirstCell"];
            
            cell.model = _todayDataArray[indexPath.row -1];
            
            
            return cell;
        }else if (indexPath.section == 2){
            
            BMDirectSeedingSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingSecondCell"];
            
            cell.model = _attentionDataArray[indexPath.row - 1];
            
            cell.avatarButton.tag = indexPath.row;
            [cell.avatarButton addTarget:self action:@selector(SecondavatarButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
            
            return cell;
        }else if (indexPath.section == 3){
            
            BMDirectSeedingThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingThirdCell"];
            cell.delegate = self;
            cell.tag = 10;
            
            cell.dataArray = _recentDataArray;
            
            return cell;
        }
        
        
        
    }
    
    
    //====================没有直播
    
    // 设置各个分区第一个cell
    if (indexPath.row == 0 && indexPath.section == 0) {
        // 设置第一个分区
        BMDirectSeedingCellToOne *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingCellToOne"];
        
        cell.imageLabelV.imageView.image = [UIImage imageNamed:@"jin"];
        cell.imageLabelV.label.text = _preview_title;
        
        if ([_preview_title isEqualToString:@"明日预告"]) {
            
            cell.imageLabelV.imageView.image = [UIImage imageNamed:@"ye"];
            
        }
        
        return cell;
        
    }else if (indexPath.row == 0 && indexPath.section == 1){
        // 设置第二个分区
        
        BMDirectSeedingCellToOne *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingCellToOne"];
        
        cell.imageLabelV.imageView.image = [UIImage imageNamed:@"xiao"];
        cell.imageLabelV.label.text = @"大家都在关注";
        return cell;
    }else if (indexPath.row == 0 && indexPath.section == 2){
        // 设置第三个分区
        
        BMDirectSeedingCellToOne *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingCellToOne"];
        
        cell.imageLabelV.imageView.image = [UIImage imageNamed:@"7"];
        cell.imageLabelV.label.text = @"近期预告";
        return cell;
    }
    
    
    // 设置第一个分区
    if (indexPath.section == 0) {
        BMDirectSeedingFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingFirstCell"];
        
        cell.model = _todayDataArray[indexPath.row -1];
        
        return cell;
    }else if (indexPath.section == 1){
        
        BMDirectSeedingSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingSecondCell"];
        
        cell.model = _attentionDataArray[indexPath.row - 1];
        
        cell.avatarButton.tag = indexPath.row;
        [cell.avatarButton addTarget:self action:@selector(SecondavatarButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
    }else if (indexPath.section == 2){
        
        BMDirectSeedingThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMDirectSeedingThirdCell"];
        cell.delegate = self;
        
        cell.tag = 10;
        
        cell.dataArray = _recentDataArray;
        
        return cell;
    }
    
    return nil;
    
}




-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

// 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 50;
    }
    
    // 如果有直播
    if (_dsDataArray.count != 0) {
        
        if (indexPath.section == 0) {
            return 280;
            
        }else if (indexPath.section == 1){
            
            return 280;
            
        }else if (indexPath.section == 3){
            
            return 660;
        }
        
        return 50;
    }
    
    // 如果没有在直播
    if (indexPath.section == 0) {
        
        return 280;
        
    }else if (indexPath.section == 2){
        
        return 660;
    }
    
    
    return 50;
}

// collection代理方法
- (void)popupTimeViewWithModel:(BMDsLiveAndPreviewModel *)model
{
    
    _timeView = [[BMToBeginPlayTimeView alloc] initWithFrame:CGRectMake(60, kScreenHeight, kScreenWidth - 120,kScreenHeight/2)];
    _timeView.autoresizesSubviews = YES;
    _timeView.backgroundColor = [UIColor whiteColor];
    
    _timeView.model = model;
    _tempModel = model;
    [_timeView.closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 添加弹窗头像点击方法
    [_timeView.avatarButton addTarget:self action:@selector(timeViewToavatr:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_timeView];
    
    [UIView animateWithDuration:.5 animations:^{
        
        CGRect newFrame = _timeView.frame;
        newFrame.origin.y = 80;
        _timeView.frame = newFrame;
        _tableView.userInteractionEnabled = NO;
        
    }];
    
}


// 分区表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 排数第一行
    if (indexPath.row == 0) {
        
        return;
    }
    
    if (indexPath.section == 0 && _dsDataArray.count == 0){
        
        // 第一个分区(今日预告)
        _tempModel = _todayDataArray[indexPath.row - 1];
        
        _timeView = [[BMToBeginPlayTimeView alloc] initWithFrame:CGRectMake(60, kScreenHeight, kScreenWidth - 120,kScreenHeight/2)];
        
        // 添加弹窗头像点击方法
        [_timeView.avatarButton addTarget:self action:@selector(timeViewToavatr:) forControlEvents:(UIControlEventTouchUpInside)];
        
        _timeView.autoresizesSubviews = YES;
        _timeView.backgroundColor = [UIColor whiteColor];
        _timeView.model = _todayDataArray[indexPath.row - 1];
        
        [_timeView.closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.view addSubview:_timeView];
        
        [UIView animateWithDuration:.5 animations:^{
            
            CGRect newFrame = _timeView.frame;
            newFrame.origin.y = 80;
            _timeView.frame = newFrame;
            _tableView.userInteractionEnabled = NO;
            
        }];
        
    }else if (_dsDataArray.count != 0 && indexPath.section == 0){
        
        // 直播分区
        _tempModel = _dsDataArray[indexPath.row - 1];
        _timeView = [[BMToBeginPlayTimeView alloc] initWithFrame:CGRectMake(60, kScreenHeight, kScreenWidth - 120,kScreenHeight/2)];
        _timeView.autoresizesSubviews = YES;
        _timeView.backgroundColor = [UIColor whiteColor];
        _timeView.model = _dsDataArray[indexPath.row - 1];
        
        [_timeView.closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        // 添加弹窗头像点击方法
        [_timeView.avatarButton addTarget:self action:@selector(timeViewToavatr:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.view addSubview:_timeView];
        
        [UIView animateWithDuration:.5 animations:^{
            
            CGRect newFrame = _timeView.frame;
            newFrame.origin.y = 80;
            _timeView.frame = newFrame;
            _tableView.userInteractionEnabled = NO;
            
        }];
        
    }else if (_dsDataArray.count != 0 && indexPath.section == 1){
        
        // 第二个分区(今日预告)
        _tempModel = _todayDataArray[indexPath.row - 1];
        _timeView = [[BMToBeginPlayTimeView alloc] initWithFrame:CGRectMake(60, kScreenHeight, kScreenWidth - 120,kScreenHeight/2)];
        _timeView.autoresizesSubviews = YES;
        _timeView.backgroundColor = [UIColor whiteColor];
        _timeView.model = _todayDataArray[indexPath.row - 1];
        
        [_timeView.closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        // 添加弹窗头像点击方法
        [_timeView.avatarButton addTarget:self action:@selector(timeViewToavatr:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.view addSubview:_timeView];
        
        [UIView animateWithDuration:.5 animations:^{
            
            CGRect newFrame = _timeView.frame;
            newFrame.origin.y = 80;
            _timeView.frame = newFrame;
            _tableView.userInteractionEnabled = NO;
            
        }];
    }
 }

#pragma mark -- 关注cell头像点击
- (void)SecondavatarButtonAction:(UIButton *)sender
{
    
    BMMicroblogVC *microblogVC = [[BMMicroblogVC alloc] init];
    
    BMDsLiveAndPreviewModel *model = _attentionDataArray[sender.tag - 1];
    
    microblogVC.uid = model.uid;
    
    [self.navigationController pushViewController:microblogVC animated:YES];
    
}

#pragma mark -- 弹窗点击方法
// 弹窗头像
- (void)timeViewToavatr:(UIButton *)sender
{
    CGRect newFrame = _timeView.frame;
    newFrame.origin.y = kScreenHeight;
    _timeView.frame = newFrame;
    _timeView = nil;
    _tableView.userInteractionEnabled = YES;
    
    BMMicroblogVC *microblogVC = [[BMMicroblogVC alloc] init];
    
    microblogVC.uid = _tempModel.uid;
    
    [self.navigationController pushViewController:microblogVC animated:YES];

}

// 关闭按钮
- (void)closeButtonAction:(UIButton *)sender
{
    [UIView animateWithDuration:.5 animations:^{
        
        CGRect newFrame = _timeView.frame;
        newFrame.origin.y = kScreenHeight;
        _timeView.frame = newFrame;
        _timeView = nil;
        _tableView.userInteractionEnabled = YES;
        
    }];
}

#pragma mark -- 跳转播放界面
- (void)transmitWithID:(NSString *)ID
{
    BMVideoShowViewController *VideoVC = [[BMVideoShowViewController alloc] init];
    VideoVC.source_id = ID;
    [self.navigationController pushViewController:VideoVC animated:YES];
    
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
