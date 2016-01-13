//
//  BMRootViewController.m
//  Temp
//
//  Created by 庄壮勇 on 16/1/9.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMRootViewController.h"

@interface BMRootViewController ()<UIScrollViewDelegate>

@end

@implementation BMRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    _navigationView = [[BMNavigationView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 50)];
    [self.view addSubview:_navigationView];
    
    [_navigationView.topToLeftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_navigationView.topToRightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    // 添加滑动视图
    _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _navigationView.bottom, kScreenWidth, kScreenHeight - _navigationView.height - 20 - 50)];
    
    [self.view addSubview:_mainScroll];
    _mainScroll.delegate = self;
   
    _mainScroll.pagingEnabled = YES;
    
    _mainScroll.showsHorizontalScrollIndicator = NO;
    _mainScroll.showsVerticalScrollIndicator = NO;
    _mainScroll.bounces = NO;
    _mainScroll.contentSize = CGSizeMake(kScreenWidth * 2,kScreenHeight - _navigationView.height - 20 - 60);

    UIView *View1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _mainScroll.height)];
    View1.backgroundColor = [UIColor redColor];
    [_mainScroll addSubview:View1];
    
}

// 结束减速
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    // 偏移量
    CGFloat x =  scrollView.contentOffset.x;
    NSLog(@"%f",x);
    // 如果大于0
    if (x > 0) {
        
        CGRect newFrame =  _navigationView.topToView.frame;
        newFrame.origin.x = _navigationView.topToRightButton.frame.origin.x;
        _navigationView.topToView.frame = newFrame;
        
        [_navigationView.topToRightButton setTitleColor:[UIColor magentaColor] forState:(UIControlStateNormal)];
        [_navigationView.topToLeftButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
    }else{
        
        CGRect newFrame =  _navigationView.topToView.frame;
        newFrame.origin.x = _navigationView.topToLeftButton.frame.origin.x;
        _navigationView.topToView.frame = newFrame;
        [_navigationView.topToLeftButton setTitleColor:[UIColor magentaColor] forState:(UIControlStateNormal)];
        [_navigationView.topToRightButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];

    }
    
}


- (void)leftButtonAction:(UIButton *)sender
{
    
    CGRect newFrame =  _navigationView.topToView.frame;
    newFrame.origin.x = sender.frame.origin.x;
    _navigationView.topToView.frame = newFrame;
    [sender setTitleColor:[UIColor magentaColor] forState:(UIControlStateNormal)];
    [_navigationView.topToRightButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    
    [_mainScroll setContentOffset:CGPointMake(0, 0) animated:YES];
    
}

- (void)rightButtonAction:(UIButton *)sender
{
    CGRect newFrame =  _navigationView.topToView.frame;
    newFrame.origin.x = sender.frame.origin.x;
    _navigationView.topToView.frame = newFrame;
    
    [sender setTitleColor:[UIColor magentaColor] forState:(UIControlStateNormal)];
    [_navigationView.topToLeftButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    
    [_mainScroll setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
    
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
