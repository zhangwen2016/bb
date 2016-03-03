//
//  BMDirectSedingMainVC.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/9.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMDirectSedingMainVC.h"
#import "BMDirectSeedingLeftVC.h"
#import "BMDirectSeedingRightVC.h"

@interface BMDirectSedingMainVC ()
@property (nonatomic,strong) BMDirectSeedingLeftVC *leftVC;
@property (nonatomic,strong) BMDirectSeedingRightVC *rightVC;

@end

@implementation BMDirectSedingMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationView.topToLeftButton setTitle:@"直播" forState:(UIControlStateNormal)];
    [self.navigationView.topToRightButton setTitle:@"关注" forState:(UIControlStateNormal)];
    
    // Do any additional setup after loading the view.
    
    
    _leftVC = [[BMDirectSeedingLeftVC alloc] init];
    _leftVC.view.frame = CGRectMake(0, 0, kScreenWidth, self.mainScroll.height);
    [self.mainScroll addSubview:_leftVC.view];

    _rightVC = [[BMDirectSeedingRightVC alloc] init];
    
    _rightVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, self.mainScroll.height);
    [self.mainScroll addSubview:_rightVC.view];

    [self addChildViewController:_leftVC];
    [self addChildViewController:_rightVC];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.tabBarController.tabBar.hidden = NO;
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
