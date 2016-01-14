//
//  BMApplyToAnchorViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMApplyToAnchorViewController.h"
#define kApplyToAnchorAPI @"http://m.meilihuli.com/wmx/apply/?sso=e4fbqygX0M1we4wk7Db%2FWZ9PDaHSetDiuPpldZVxJcikYtno"

@interface BMApplyToAnchorViewController ()

@property (nonatomic, strong)UIWebView *webView;

@end

@implementation BMApplyToAnchorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addWebView];
    [self loadNavView];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)loadNavView{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"申请成为主播";
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

- (void)addWebView
{
    NSURL *url = [NSURL URLWithString:kApplyToAnchorAPI];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight - 70)];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
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
