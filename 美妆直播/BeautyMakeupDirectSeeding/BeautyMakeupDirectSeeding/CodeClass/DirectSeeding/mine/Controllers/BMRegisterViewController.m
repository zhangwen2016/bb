//
//  BMRegisterViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/19.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMRegisterViewController.h"
#import "BMCommonMethod.h"
#import "BMRequestManager.h"
#define kTFTag 1444
#define kGetAuthCode @"http://user.meilihuli.com/api/user/findregistercode/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"

@interface BMRegisterViewController ()

@property (nonatomic, strong)UITextField *phoneNumberTF;//  手机账号
@property (nonatomic, strong)UITextField *authCode;//  验证码;
@property (nonatomic, strong)UIButton *getAuthCodeBtn;//  获取验证码btn
@property (nonatomic, strong)UIButton *nextBtn;//  下一步;

@property (nonatomic, assign)NSInteger number;//  倒计时计数


@end

@implementation BMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNavView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubView];
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

- (void)addSubView
{
    NSArray *textFieldDataSource = @[@"请输入手机账号", @"请输入验证码"];
    for (int i = 0; i < 2; i++) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 100 + 40 * i, kScreenWidth, 40)];
        tf.tag = kTFTag + i;
        tf.placeholder = textFieldDataSource[i];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:tf];
    }
    _phoneNumberTF = [self.view viewWithTag:kTFTag];
    _authCode = [self.view viewWithTag:kTFTag + 1];
    
    _getAuthCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getAuthCodeBtn.frame = CGRectMake(kScreenWidth - 100, 5, 80, 30);
    [_getAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getAuthCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _getAuthCodeBtn.titleLabel.font = [UIFont systemFontOfSize:kSmallFont];
    _getAuthCodeBtn.backgroundColor = [UIColor magentaColor];
    [_authCode addSubview:_getAuthCodeBtn];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.backgroundColor = [UIColor magentaColor];
    _nextBtn.frame = CGRectMake((kScreenWidth - 300) / 2, _authCode.bottom + 30, 300, 30);
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:_nextBtn];
    
    [_getAuthCodeBtn addTarget:self action:@selector(authCodeAction:) forControlEvents:UIControlEventTouchUpInside];
}

//  点击返回 返回到上个界面
- (void)backButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//  点击获取验证码
- (void)authCodeAction:(UIButton *)sender
{
    _phoneNumberTF = [self.view viewWithTag:kTFTag];

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"mobile"] = _phoneNumberTF.text;
    
    
    [BMRequestManager requsetWithUrlString:kGetAuthCode parDic:dic Method:POST finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        NSString *errmsg = dic[@"errmsg"];
        
        if ([errmsg isEqualToString:@"发送成功"]) {
            
        }else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:errmsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            [alertView show];
        }
        NSLog(@"%@", errmsg);
        
    } erro:^(NSError *erro) {
        nil;
    }];
}

- (void)fireTimer
{
    // 给一个时间的初值
    self.number = 5;
    // 倒计时 核心 每隔一秒中 时间递减
    // 计时器 (可以实现 每隔多少时间调用一个方法)
    // NSTimeInterval 代表时间间隔
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerClick:) userInfo:@"button倒计时" repeats:YES];
    // 计时器开始
    [timer fire];
    
    // 关闭交互
    _getAuthCodeBtn.userInteractionEnabled = NO;
}

- (void)timerClick:(NSTimer *)timer
{
    
    NSLog(@"调用了吗?");
    // button 该标题
    NSString *title = [NSString stringWithFormat:@"%ld后重新发送", self.number--];
    // 取出button赋值标题
    UIButton *button = (UIButton *)[self.view viewWithTag:20];
    [button setTitle:title forState:(UIControlStateNormal)];
    
    // 判断倒计时 是否结束 标题是否为0
    if ([[button titleForState:(UIControlStateNormal)] isEqualToString:@"0后重新发送"]) {
        
        // 停止计时器
        [timer invalidate];
        
        // 更改button的标题
        [button setTitle:@"重新发送验证码" forState:(UIControlStateNormal)];
        // 重新打开交互
        button.userInteractionEnabled = YES;
        
        // 重置时间
        self.number = 60;
        
    }
    
    
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
