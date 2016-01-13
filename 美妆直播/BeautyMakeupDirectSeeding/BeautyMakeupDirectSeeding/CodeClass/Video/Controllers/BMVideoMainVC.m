//
//  BMVideoMainVC.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/9.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMVideoMainVC.h"
#import "BMVideoRecommendViewController.h"
@interface BMVideoMainVC ()

@end

@implementation BMVideoMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationView.topToLeftButton setTitle:@"推荐" forState:(UIControlStateNormal)];
    [self.navigationView.topToRightButton setTitle:@"热门" forState:(UIControlStateNormal)];
    BMVideoRecommendViewController *recommendVC = [[BMVideoRecommendViewController alloc] init];
    recommendVC.view.frame = CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height - 64);
    [self.view addSubview:recommendVC.view];
    [self addChildViewController:recommendVC];
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
