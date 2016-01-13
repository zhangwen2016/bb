//
//  BMVideoHotTagViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMVideoHotTagViewController.h"

@interface BMVideoHotTagViewController ()

@end

@implementation BMVideoHotTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadNavView];
}
- (void)loadNavView{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
    UILabel *label = [[UILabel alloc] init];
    label.text = _hotTagModel.name;
    label.textColor = [UIColor colorWithRed:255/255.0 green:75 / 255.0 blue:124 / 255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:16];
    [BMCommonMethod autoAdjustLeftWidthLabel:label labelFontSize:16];
    label.frame = CGRectMake((navView.width - label.width) / 2, 20, label.width, 50);
    [navView addSubview:label];
    [self.view addSubview:navView];
    
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(10, 30, 20, 20);
    backButton.tintColor =[UIColor colorWithRed:255/255.0 green:75 / 255.0 blue:124 / 255.0 alpha:1];
    [backButton setBackgroundImage:[UIImage imageNamed:@"all_topback.png"] forState:(UIControlStateNormal)];
    [navView addSubview:backButton];
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
