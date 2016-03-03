//
//  BMAllTagViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMAllTagViewController.h"
#import "BMCommonMethod.h"
#import "BMVideoHotTag.h"
#define kAllTagApi @"http://app.meilihuli.com/api/tag/recommendall/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"
@interface BMAllTagViewController ()
@property (nonatomic, strong) NSMutableArray *hotTagArray;
@property (nonatomic, strong) BMVideoHotTag *hotTagView;
@end

@implementation BMAllTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    [self loadNavView];
    [self loadAllTagView];
    [self JsonData];
}
#pragma mark ---- 标题
- (void)loadNavView{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"全部标签";
    label.textColor = kPinkColor;
    label.font = [UIFont systemFontOfSize:16];
    [BMCommonMethod autoAdjustLeftWidthLabel:label labelFontSize:16];
    label.frame = CGRectMake((navView.width - label.width) / 2, 20, label.width, 50);
    [navView addSubview:label];
    [self.view addSubview:navView];
    
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(10, 35, 20, 20);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [navView addSubview:backButton];
}
- (void)backButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)JsonData{
    _hotTagArray = [NSMutableArray array];
    [BMRequestManager requsetWithUrlString:kAllTagApi parDic:nil Method:GET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *oneDic in dataArray) {
            BMVideoHotTagModel *model = [[BMVideoHotTagModel alloc] init];
            [model setValuesForKeysWithDictionary:oneDic];
            [_hotTagArray addObject:model];
        }
        _hotTagView.sourceArray = _hotTagArray;
    } erro:^(NSError *erro) {
        [BMCommonMethod NoNetWorkInVC:self];
    }];
}

- (void)loadAllTagView{
    _hotTagView = [[BMVideoHotTag alloc] initWithFrame:CGRectMake(0, 70,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 70)];
    _hotTagView.currentVC = self;
    [self.view addSubview:_hotTagView];
    
    
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
