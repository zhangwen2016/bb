//
//  BMDirectSedingMainVC.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/9.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMDirectSedingMainVC.h"
#import "BMDirectSeedingLeftVC.h"

@interface BMDirectSedingMainVC ()
@property (nonatomic,strong) BMDirectSeedingLeftVC *leftVC;

@end

@implementation BMDirectSedingMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationView.topToLeftButton setTitle:@"直播" forState:(UIControlStateNormal)];
    [self.navigationView.topToRightButton setTitle:@"关注" forState:(UIControlStateNormal)];
    
    // Do any additional setup after loading the view.
    
    
    _leftVC = [[BMDirectSeedingLeftVC alloc] init];
    
    [self.mainScroll addSubview:_leftVC.view];

    
    
    
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
