//
//  BMAnchorRankMainViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMAnchorRankMainViewController.h"
#import "BMAnchorRankChildViewController.h"

////  月人气排行API
//#define kSubscribe_monthAPI @"http://app.meilihuli.com/api/discover/teacherranklist/count/30/order/subscribe_month/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"

//  月人气排行API
#define kSubscribe_monthAPIPart1 @"http://app.meilihuli.com/api/discover/teacherranklist/count/30/order/subscribe_month/page/"
//  月人气排行API
#define kSubscribe_monthAPIPart2 @"/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"
////  总人气排行API
//#define kSubscribe @"http://app.meilihuli.com/api/discover/teacherranklist/count/30/order/subscribe/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"
#define kSubscribePart1 @"http://app.meilihuli.com/api/discover/teacherranklist/count/30/order/subscribe/page/"
#define kSubscribePar2 @"/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"

////  月收益API
//#define kWallet_month @"http://app.meilihuli.com/api/discover/teacherranklist/count/30/order/wallet_month/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"

//  月收益API
#define kWallet_monthPart1 @"http://app.meilihuli.com/api/discover/teacherranklist/count/30/order/wallet_month/page/"
//  月收益API
#define kWallet_monthPart2 @"/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"

////  总收益API
//#define kWallet @"http://app.meilihuli.com/api/discover/teacherranklist/count/30/order/wallet/page/1/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"
//  总收益API
#define kWalletPart1 @"http://app.meilihuli.com/api/discover/teacherranklist/count/30/order/wallet/page/"
//  总收益API
#define kWalletPart2 @"/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"

#define kTitleTag 1000

@interface BMAnchorRankMainViewController ()

@property (nonatomic, strong) UIScrollView *mainScrollView;//  放两个子视图的背景scrollView
@property (nonatomic, strong) BMAnchorRankChildViewController *monthRank;//  月排行榜controller
@property (nonatomic, strong) BMAnchorRankChildViewController *totalRank;//  总排行榜controller
@property (nonatomic, strong) UIView *pinkView;//  下面的粉色滑动条

@end

@implementation BMAnchorRankMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildNavBar];
    [self addScrollView];
    [self addChildVC];
    //  影藏下面的tabBar
    self.tabBarController.tabBar.hidden = YES;
    [self loadNavView];
}

- (void)loadNavView{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"排行榜";
    label.textColor = kPinkColor;
    label.font = [UIFont systemFontOfSize:16];
    label.frame = CGRectMake((navView.width - 200) / 2, 20, 200, 50);
    label.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:label];
    [self.view addSubview:navView];
    
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(10, 35, 20, 20);
    backButton.backgroundColor = kPinkColor;
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [navView addSubview:backButton];
}

//  点击返回
- (void)backButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark  给navbar下面的两个选择btn初始化
- (void)addChildNavBar
{
    NSArray *titleArr = @[@"月人气排行榜", @"总人气排行榜"];
    //  添加月人气排行榜 和总人气排行榜
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreenWidth / 2 * i, 70, kScreenWidth / 2, 30);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = kTitleTag + i;
        [btn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
    
    UIButton *btn = [self.view viewWithTag:kTitleTag + 1];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _pinkView = [[UIView alloc] initWithFrame:CGRectMake(0, 98, kScreenWidth / 2, 2)];
    _pinkView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:_pinkView];
}

- (void)addScrollView
{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight - 100)];
    _mainScrollView.contentSize = CGSizeMake((kScreenWidth) * 2, (kScreenHeight - 100));
    _mainScrollView.bounces = NO;
    _mainScrollView.pagingEnabled = NO;
    _mainScrollView.contentOffset = CGPointMake(0, 200);
    _mainScrollView.scrollEnabled = NO;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    NSLog(@"~~~%f", _mainScrollView.contentSize.width);
    _mainScrollView.showsHorizontalScrollIndicator = NO;

    [self.view addSubview:_mainScrollView];
}

- (void)addChildVC
{
    _monthRank = [[BMAnchorRankChildViewController alloc] init];
    _monthRank.view.frame = CGRectMake(0, 200, kScreenWidth, kScreenHeight - 100);
    if (_isSubscribe == YES) {
        _monthRank.rankAPIPart1 = kSubscribe_monthAPIPart1;
        _monthRank.rankAPIPart2 = kSubscribe_monthAPIPart2;
    }else
    {
        _monthRank.rankAPIPart1 = kWallet_monthPart1;
        _monthRank.rankAPIPart2 = kWallet_monthPart2;
    }
    [_mainScrollView addSubview:_monthRank.view];
    [self addChildViewController:_monthRank];
    
    _totalRank = [[BMAnchorRankChildViewController alloc] init];
    _totalRank.view.frame = CGRectMake(kScreenWidth, 200, kScreenWidth, kScreenHeight);
    if (_isSubscribe == YES) {
        _totalRank.rankAPIPart1 = kSubscribePart1;
        _totalRank.rankAPIPart2 = kSubscribePar2;

    }else
    {
        _totalRank.rankAPIPart1 = kWalletPart1;
        _totalRank.rankAPIPart2 = kWalletPart2;

    }
    [_mainScrollView addSubview:_totalRank.view];
    [self addChildViewController:_totalRank];
    
   
}

#pragma mark  点击月/总btn 实现scrollView的位移
- (void)titleBtnAction:(UIButton *)sender
{
    if (sender.tag == kTitleTag) {
        [_mainScrollView setContentOffset:CGPointMake(0, 200) animated:YES];
        [sender setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        UIButton *btn = [self.view viewWithTag:kTitleTag + 1];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.2 animations:^{
            _pinkView.frame = CGRectMake(0, 98, kScreenWidth / 2, 2);
        }];
        
    }else
    {
        [_mainScrollView setContentOffset:CGPointMake(kScreenWidth, 200) animated:YES];
        [sender setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        UIButton *btn = [self.view viewWithTag:kTitleTag];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            _pinkView.frame = CGRectMake(kScreenWidth / 2, 98, kScreenWidth / 2, 2);
        }];
    }
}

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
