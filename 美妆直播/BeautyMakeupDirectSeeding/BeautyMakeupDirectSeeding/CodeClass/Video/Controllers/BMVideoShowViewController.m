//
//  BMVideoShowViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMVideoShowViewController.h"
#import "KrVideoPlayerController.h"
#import "BMShowVideoHeaderView.h"
#import "BMVideoMainModel.h"
#import "BMShareModel.h"
#import "BMCommentListModel.h"
#import "BMGoodsListTableViewCell.h"
#import "BMVideoLiveTableViewCell.h"
#import "BMteacherRecommendTableViewCell.h"
#import "BMMicroblogVC.h"
@interface BMVideoShowViewController () <UITableViewDataSource, UITableViewDelegate, BMRecommendTeacherDelegate>
@property (nonatomic, strong) KrVideoPlayerController  *videoController;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) BMShowVideoHeaderView *headerView;

//@property (nonatomic, strong) NSMutableArray *personDetailArray;
@property (nonatomic, strong) NSMutableDictionary *shareDic;
@property (nonatomic, strong) BMPersonDetailModel *personModel;
@property (nonatomic, strong) NSMutableDictionary *goodListDic;
@property (nonatomic, strong) NSMutableArray *videoRecommendArray;
@property (nonatomic, strong) NSMutableArray *teacherRecommendArray;
@property (nonatomic, strong) NSMutableArray *commentListArray;

@property (nonatomic, assign) NSInteger page;

@end

@implementation BMVideoShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    _page = 1;
    [self storeArray];
    [self JsonData];
    [self loadTableView];
    [self playVideo];
    [self showBackBtnAndShareBtn];
    
    
    
}
- (void)showBackBtnAndShareBtn{
    _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _backBtn.frame = CGRectMake(10, 10, 40, 40);
    _backBtn.layer.cornerRadius = 20;
    [_backBtn setImage:[UIImage imageNamed:@"all_topback.png"] forState:(UIControlStateNormal)];
    [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_backBtn];
    
    _shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _shareBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 10, 40, 40);
    [_shareBtn setImage:[UIImage imageNamed:@"MeiliFamilyCmt.png"] forState:(UIControlStateNormal)];
    _shareBtn.layer.cornerRadius = 20;
    [_shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_shareBtn];
    
    // 5秒后消失
    [self performSelector:@selector(ButtonHidden) withObject:nil afterDelay:7];
}

- (void)backBtnClick:(UIButton *)button{
    [_videoController dismiss];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)shareBtnClick:(UIButton *)button{
    NSLog(@"111");
   // [_listTableView removeFromSuperview];
    
}
- (void)ButtonHidden{
    if (!_backBtn.hidden) {
        [UIView animateWithDuration:0.3 animations:^{
            _backBtn.alpha = 0;
            _shareBtn.alpha = 0;
        }];
    }
}


- (void)playVideo{
    
    NSString *urlString = [@"http://apps.mushu.cn/jc_" stringByAppendingString:[NSString stringWithFormat:@"%@_m_big_hd.mp4", _source_id]];
    NSURL *url = [NSURL URLWithString:urlString];
    [self addVideoPlayerWithURL:url];
}

- (void)addVideoPlayerWithURL:(NSURL *)url{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, width*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController setWillBackOrientationPortrait:^{
            [weakSelf toolbarHidden:NO];
        }];
        [self.videoController setWillChangeToFullscreenMode:^{
            [weakSelf toolbarHidden:YES];
        }];
        [self.view addSubview:self.videoController.view];
        
        self.videoController.fullBlock = ^void(){
            weakSelf.shareBtn.hidden = YES;
            weakSelf.backBtn.hidden = YES;
            _isFullScreen = YES;
        };
        self.videoController.smallBlock = ^void(){
            weakSelf.shareBtn.hidden = NO;
            weakSelf.backBtn.hidden = NO;
            _isFullScreen = NO;
        };
    }
    self.videoController.contentURL = url;  
}
//隐藏navigation tabbar 电池栏
- (void)toolbarHidden:(BOOL)Bool{
    self.navigationController.navigationBar.hidden = Bool;
    self.tabBarController.tabBar.hidden = Bool;
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationNone];
}

#pragma mark ---- 点击的时候显示backButton 和 sharebutton
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint p1 =[touch locationInView:self.view];
    if (p1.y < [UIScreen mainScreen].bounds.size.width / 16 * 9 && _isFullScreen == NO) {
        [UIView animateWithDuration:0.3 animations:^{
            if (_shareBtn.alpha == 0) {
                _shareBtn.alpha = 1;
                _backBtn.alpha = 1;
            }else{
                _shareBtn.alpha = 0;
                _backBtn.alpha = 0;
            }
        }];
    }
}


- (void)storeArray{
    _goodListDic = [NSMutableDictionary dictionary];
    _shareDic = [NSMutableDictionary dictionary];
    _videoRecommendArray = [NSMutableArray array];
    _teacherRecommendArray = [NSMutableArray array];
     _commentListArray = [NSMutableArray array];
}

- (void)JsonData{
    
    NSString  *personGoodsApi = [@"http://app.meilihuli.com/api/live/video/live_id/" stringByAppendingString:[NSString stringWithFormat:@"%@/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8", _live_id]];
    if (_source_id.length != 0) {
        
        personGoodsApi = [@"http://app.meilihuli.com/api/course/detail/course_id/" stringByAppendingString:[NSString stringWithFormat:@"%@/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8", _source_id]];
    }
    NSLog(@"%@", personGoodsApi);
    
    [BMRequestManager requsetWithUrlString:personGoodsApi httpBodyStr:nil Method:GET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        // 得到headerView
        NSDictionary *dataDic = dic[@"data"];
        _personModel = [[BMPersonDetailModel alloc] init];
        [_personModel setValuesForKeysWithDictionary:dataDic];
        _headerView.personModel = _personModel;
        _headerView.currentVC = self;
        
        // 得到goodsList的部分
        NSArray *goodsArray = dataDic[@"relation_goods_list"];
        for (NSDictionary *oneDic in goodsArray) {
            NSString *key = oneDic[@"category_name"];
            NSMutableArray *temp = [NSMutableArray array];
            NSArray *array = oneDic[@"product_list"];
            for (NSDictionary *oDic in array) {
                BMGoodsListModel *goodsModel = [[BMGoodsListModel alloc] init];
                [goodsModel setValuesForKeysWithDictionary:oDic];
                [temp addObject:goodsModel];
            }

            [_goodListDic setObject:temp forKey:key];
            
        }
       
        // 得到shareDic
        NSDictionary *share = dataDic[@"share_config"];
        NSArray *tempArray = @[@"weibo", @"weixin_friend", @"qq_space",@"qq_friend", @"weixin_friends"];
        for (NSString *str in tempArray) {
            NSDictionary *temp = share[str];
            BMShareModel *shareModel = [[BMShareModel alloc] init];
            [shareModel setValuesForKeysWithDictionary:temp];
            [_shareDic setValue:shareModel forKey:str];
        }
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:0];
        [_listTableView reloadSections:set withRowAnimation:(UITableViewRowAnimationNone)];
    } erro:^(NSError *erro) {
        nil;
    }];
    
    // 解析推荐视频
    
     NSString *videoRecommendApi = [@"http://app.meilihuli.com/api/course/detailcoursecommend/count/4/course_id/" stringByAppendingString:[NSString stringWithFormat:@"%@/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8", _live_id]];
    
    if (_source_id.length != 0) {
        
        videoRecommendApi = [@"http://app.meilihuli.com/api/course/detailcoursecommend/count/4/course_id/" stringByAppendingString:[NSString stringWithFormat:@"%@/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8", _source_id]];
    }
    [BMRequestManager requsetWithUrlString:videoRecommendApi parDic:nil Method:GET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *oneDic in dataArray) {
            BMSearchTeacherModel *videoModel = [[BMSearchTeacherModel alloc] init];
            [videoModel setValuesForKeysWithDictionary:oneDic];
            [_videoRecommendArray addObject:videoModel];
        }
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:1];
        [_listTableView reloadSections:set withRowAnimation:(UITableViewRowAnimationNone)];
    } erro:^(NSError *erro) {
        nil;
    }];
    
    
    // 主播推荐
    
    NSString *teacherRecommendApi = @"http://app.meilihuli.com/api/teacher/recommendlist/count/4/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8";
    [BMRequestManager requsetWithUrlString:teacherRecommendApi parDic:nil Method:GET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *oneDic in dataArray) {
            BMRecommendTeacherModel *teacherModel = [[BMRecommendTeacherModel alloc] init];
            [teacherModel setValuesForKeysWithDictionary:oneDic];
            [_teacherRecommendArray addObject:teacherModel];
        }
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:2];
        [_listTableView reloadSections:set withRowAnimation:(UITableViewRowAnimationNone)];
    } erro:^(NSError *erro) {
        nil;
    }];
    
    // 讨论
   
//    NSString *commentApi =  [@"http://app.meilihuli.com/api/comment/list/source_id/" stringByAppendingString:[NSString stringWithFormat:@"%@/type/1/count/10/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8", _source_id]];
//    [BMRequestManager requsetWithUrlString:commentApi parDic:nil Method:GET finish:^(NSData *data) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSArray *dataArray = dic[@"data"];
//        for (NSDictionary *oneDic in dataArray) {
//            BMCommentListModel *listModel = [[BMCommentListModel alloc] init];
//            [listModel setValuesForKeysWithDictionary:oneDic];
//            [_commentListArray addObject:listModel];
//        }
    
//        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:3];
//        [_listTableView reloadSections:set withRowAnimation:(UITableViewRowAnimationNone)];
//    } erro:^(NSError *erro) {
//        nil;
//    }];
    
    
}





- (void)loadTableView{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, width / 16 * 9, width, [UIScreen mainScreen].bounds.size.height - width / 16 * 9) style:(UITableViewStyleGrouped)];
    _listTableView.dataSource = self;
    _listTableView.delegate = self;
    _listTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_listTableView registerClass:[BMGoodsListTableViewCell class] forCellReuseIdentifier:@"BMGoodsListTableViewCell"];
    [_listTableView registerClass:[BMVideoLiveTableViewCell class] forCellReuseIdentifier:@"BMVideoLiveTableViewCell"];
    [_listTableView registerClass:[BMteacherRecommendTableViewCell class] forCellReuseIdentifier:@"BMteacherRecommendTableViewCell"];
    _headerView = [[BMShowVideoHeaderView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    _listTableView.tableHeaderView = _headerView;
    [self.view addSubview:_listTableView];
   
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  // return 4;
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        BMGoodsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMGoodsListTableViewCell" forIndexPath:indexPath];
        cell.dataDic = _goodListDic;
        return cell;
    }else if (indexPath.section == 1){
        BMVideoLiveTableViewCell *liveCell = [tableView dequeueReusableCellWithIdentifier:@"BMVideoLiveTableViewCell" forIndexPath:indexPath];
        liveCell.currentVC = self;
        liveCell.liveArray = _videoRecommendArray;
        return liveCell;
    }else if (indexPath.section == 2){
        BMteacherRecommendTableViewCell *teacherCell = [tableView dequeueReusableCellWithIdentifier:@"BMteacherRecommendTableViewCell" forIndexPath:indexPath];
        teacherCell.delegate = self;
        teacherCell.teacherArray = _teacherRecommendArray;
        return teacherCell;
    }
    return nil;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        
    }
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 如果没有的话 删除分区return 0;
    if (indexPath.section == 0) {
        if ([_goodListDic allKeys].count != 0) {
            NSInteger count = 0;
            NSArray *keyArray = [_goodListDic allKeys];
            for (NSString *str in _goodListDic) {
                NSArray *array = _goodListDic[str];
                count = count + array.count;
            }
            count += keyArray.count;
            return count * 20;
        }else{
            return 0;
        }
        
    }else if (indexPath.section == 1){
        if (_videoRecommendArray.count != 0) {
            if (_videoRecommendArray.count % 2 == 1) {
                return (_videoRecommendArray.count + 1) / 2 * 150 + 20;
            }
            return _videoRecommendArray.count / 2 * 150 + 20;
        }else{
            return 0;
        }
        
    }else if (indexPath.section == 2){
        if (_teacherRecommendArray.count != 0) {
            return 125;
        }else{
            return 0;
        }
    }
    return 100;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *array = @[@"提及产品", @"视频推荐", @"主播推荐"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _listTableView.frame.size.width, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 15)];
    titleLabel.textColor = kPinkColor;
    // 保护
    if (section < 4) {
        titleLabel.text = array[section];
    }
    titleLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:titleLabel];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSArray *array = @[[_goodListDic allKeys], _videoRecommendArray, _teacherRecommendArray];
    for (NSArray *onearray in array) {
        if (onearray.count != 0 ) {
            return 30;
        }else{
            return 0;
        }
    }
    return 0;
}


// 推荐老师的代理方法
- (void)sendButtonModel:(BMRecommendTeacherModel *)model{
    BMMicroblogVC *blogVC = [[BMMicroblogVC alloc] init];
    blogVC.uid = model.uid;
    [self.navigationController pushViewController:blogVC animated:YES];
}





// 刷新数据
- (void)reloadData{
    _listTableView.contentOffset = CGPointMake(0, 0);
    [self playVideo];
    [self removeArray];
    [_listTableView removeFromSuperview];
    [self loadTableView];
    [self JsonData];
   
}
- (void)removeArray{
    [_goodListDic removeAllObjects];
    [_shareDic removeAllObjects];
    [_videoRecommendArray removeAllObjects];
    [_teacherRecommendArray removeAllObjects];
    [_commentListArray removeAllObjects];
    
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
//   BMteacherRecommendTableViewCell *teacherCell = [_listTableView cellForRowAtIndexPath:indexPath];
//    [teacherCell removeBgScrollView];
//    teacherCell.teacherArray = _teacherRecommendArray;
    
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
