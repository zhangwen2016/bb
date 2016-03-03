//
//  BMVideoMainVC.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/9.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMVideoMainVC.h"
#import "BMVideoRecommendViewController.h"
#import "BMVideoHotViewController.h"
@interface BMVideoMainVC ()

@end

@implementation BMVideoMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationView.topToLeftButton setTitle:@"推荐" forState:(UIControlStateNormal)];
    [self.navigationView.topToRightButton setTitle:@"热门" forState:(UIControlStateNormal)];
    [self loadRecommendVC];
    [self loadHotVC];
  
}
- (void)loadRecommendVC{
    
    BMVideoRecommendViewController *recommendVC = [[BMVideoRecommendViewController alloc] init];
    recommendVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height - 70);
    [self.mainScroll addSubview:recommendVC.view];
    [self addChildViewController:recommendVC];
    
}
- (void)loadHotVC{
    BMVideoHotViewController *hotVC = [[BMVideoHotViewController alloc] init];
    hotVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height - 70);
    [self.mainScroll addSubview:hotVC.view];
    [self addChildViewController:hotVC];
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
