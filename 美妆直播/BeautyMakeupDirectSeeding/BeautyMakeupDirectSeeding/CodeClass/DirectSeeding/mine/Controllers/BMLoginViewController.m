//
//  BMLoginViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/19.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMLoginViewController.h"
#import "BMLoginView.h"
#import "BMCommonMethod.h"
#import "BMRegisterViewController.h"
#import "BMRequestManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "BMLoginState.h"

@interface BMLoginViewController ()

@property (nonatomic, strong)BMLoginView *loginView;

@end

@implementation BMLoginViewController

- (void)loadView
{
    [super loadView];
    _loginView = [[BMLoginView alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight - 70)];
    self.view =_loginView;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNavView];
    [self addFunctionInView];
}

- (void)loadNavView{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"登陆";
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

- (void)addFunctionInView
{
    [_loginView.rigisterBtn addTarget:self action:@selector(RegisterAction:) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

//  点击返回实现的 方法
- (void)backButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

//  点击注册页面
- (void)RegisterAction:(UIButton *)sender
{
    BMRegisterViewController *registerVC = [[BMRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

//  点击登陆
- (void)loginBtnAction:(UIButton *)sender
{
    NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
    parDic[@"mobile"] = _loginView.accountTf.text;
    parDic[@"password"]= [self md5:_loginView.passwordTf.text];
    [BMRequestManager requsetWithUrlString:@"http://user.meilihuli.com/api/user/login/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8" parDic:parDic Method:POST finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *errmsg = dic[@"errmsg"];
        if (errmsg.length != 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:errmsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            [alertView show];
        }else{
            BMLoginState *loginState = [BMLoginState shareBMLoginState];
            loginState.isLogin = YES;
            loginState.uid = dic[@"data"][@"uid"];
            loginState.sso = dic[@"data"][@"sso"];
            if (_delegate != nil && [_delegate respondsToSelector:@selector(changeStateWithDidlogin)]) {
                [_delegate changeStateWithDidlogin];
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } erro:^(NSError *erro) {
        nil;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 密码加密
-(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0], result[1], result[2], result[3],result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
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
