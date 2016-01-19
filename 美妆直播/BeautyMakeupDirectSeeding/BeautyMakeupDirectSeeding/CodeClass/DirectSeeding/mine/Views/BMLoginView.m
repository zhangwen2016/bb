//
//  BMLoginView.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/19.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMLoginView.h"
#define kTFTag 1111
#define kBtnTag 1222

@implementation BMLoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview];
    }
    return self;
}

- (void)addSubview{
    NSArray *tfDataSource = @[@"请输入手机号", @"请输入六位数字密码"];
    for (int i = 0; i < 2; i++) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake((kScreenWidth - 300) / 2, 100 + (30 + 10) * i, 300, 30)];
        tf.placeholder = tfDataSource[i];
        tf.tag = kTFTag + i;
        [self addSubview:tf];
    }
    
    _accountTf = [self viewWithTag:kTFTag];
    _passwordTf = [self viewWithTag:kTFTag + 1];
    
    
    NSArray *btnDataSource = @[@"登陆", @"注册"];
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(_accountTf.left, _passwordTf.bottom + 30 + (30 + 10) * i, _accountTf.width, _accountTf.height);
        btn.backgroundColor = [UIColor magentaColor];
        btn.layer.cornerRadius = 30 / 2;
        btn.layer.masksToBounds = YES;
        [btn setTitle:btnDataSource[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.tag = kBtnTag + i;
        [self addSubview:btn];
    }
    
    _loginBtn = [self viewWithTag:kBtnTag];
    _rigisterBtn = [self viewWithTag:kBtnTag + 1];
    
}

@end
