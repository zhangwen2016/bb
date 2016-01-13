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
}

- (void)addWebView
{
    NSURL *url = [NSURL URLWithString:kApplyToAnchorAPI];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight - 70)];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
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
