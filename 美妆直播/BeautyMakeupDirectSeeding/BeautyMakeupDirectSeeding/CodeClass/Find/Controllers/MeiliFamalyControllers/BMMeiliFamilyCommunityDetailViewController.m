//
//  BMMeiliFamilyCommunityDetailViewController.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMMeiliFamilyCommunityDetailViewController.h"
#import "BMRequestManager.h"
#import "BMMeiliFamilyCommunityDetailView.h"
#import "BMCommonMethod.h"
#import "BMRequestManager.h"
#import "HcCustomKeyboard.h"


#define kCommunityAPIPart1 @"http://app.meilihuli.com/api/activity/detail/id/"

#define kCommunityAPIPart2 @"/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"


@interface BMMeiliFamilyCommunityDetailViewController ()

@property (nonatomic, strong) BMMeiliFamilyCommunityDetailView *communityDetailV;
@property (nonatomic, strong) NSMutableArray *btnArr;//  存放表头照片的数组
@property (nonatomic, strong) NSMutableArray *labelArr;//  存放note的数组

@end

@implementation BMMeiliFamilyCommunityDetailViewController

- (void)loadView
{
    [super loadView];
    _communityDetailV = [[BMMeiliFamilyCommunityDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _communityDetailV.activity_id = _activity_id;
    self.view = _communityDetailV;
    
    self.tabBarController.tabBar.hidden = YES;
    [self loadNavView];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;

}

- (void)loadNavView{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"美狸家";
    label.textColor = kPinkColor;
    label.font = [UIFont systemFontOfSize:16];
    label.frame = CGRectMake((navView.width - 200) / 2, 20, 200, 50);
    label.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:label];
    [self.view addSubview:navView];
    
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(10, 35, 20, 20);
    backButton.backgroundColor = kPinkColor;
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [navView addSubview:backButton];
}

//  点击返回
- (void)backButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    //  输入框
    [[HcCustomKeyboard customKeyboard]textViewShowView:self customKeyboardDelegate:self];
}

//  点击发送
-(void)talkBtnClick:(UITextView *)textViewGet
{
    NSLog(@"%@",textViewGet.text);
}

- (void)loadData
{
    NSString *api = [[kCommunityAPIPart1 stringByAppendingString:_activity_id] stringByAppendingString:kCommunityAPIPart2];
    
    
    [BMRequestManager requsetWithUrlString:api parDic:nil Method:GET finish:^(NSData *data)  {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        [self upDateViewWithDataDictionary:dataDic];
        [self.communityDetailV.tableView reloadData];
    } erro:^(NSError *erro) {
        NSLog(@"erro");
    }];
    
}

//  更新页面
- (void)upDateViewWithDataDictionary:(NSDictionary *)dataDic
{
    _communityDetailV.activity_title.text = (NSString *)dataDic[@"activity_title"];
    
    [BMCommonMethod autoAdjustHeightLabel:(UILabel *)_communityDetailV.activity_title labelFontSize:kLargeFont];
    
    _communityDetailV.avatarLineView.top = _communityDetailV.activity_title.bottom + 10;
    
    [BMRequestManager downLoadImageView:_communityDetailV.avatarImgV UrlString:dataDic[@"avatar"]];
    _communityDetailV.avatarImgV.layer.cornerRadius = _communityDetailV.avatarImgV.width / 2;
    _communityDetailV.avatarImgV.layer.masksToBounds = YES;
    
    _communityDetailV.nicknameLable.text = dataDic[@"nickname"];
    
    [self adjustTimeWithStr:dataDic[@"add_time"]];
    
    _communityDetailV.intro.top = _communityDetailV.avatarLineView.bottom + 10;
    _communityDetailV.intro.text = dataDic[@"intro"];
    [BMCommonMethod autoAdjustHeightLabel:_communityDetailV.intro labelFontSize:kSmallFont];
    
    NSArray *imgListArr = dataDic[@"img_list"];
    _btnArr = [NSMutableArray array];
    _labelArr = [NSMutableArray array];
    
    //  如果没有img
    if (imgListArr.count == 0) {
        _communityDetailV.headerView.height = _communityDetailV.intro.bottom + 10;
    }
    
    
    if (imgListArr.count != 0) {
        NSDictionary *imgDic = imgListArr[0];
        NSString *width = imgDic[@"width"];
        NSString *height = imgDic[@"height"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, _communityDetailV.intro.bottom + 10, kScreenWidth - 20, (kScreenWidth - 20) * width.floatValue / height.floatValue);
        NSString *urlStr = imgDic[@"url"];
        [BMRequestManager downLoadButton:btn UrlString:urlStr];
        
        // 加到上面
        [_communityDetailV.headerView addSubview:btn];
        [_btnArr addObject:btn];
        
        //noteLabel
        UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, btn.bottom + 10, kScreenWidth - 20, 20)];
        noteLabel.numberOfLines = -1;
        noteLabel.font = [UIFont systemFontOfSize:kSmallFont];
        noteLabel.text = imgDic[@"note"];
        [BMCommonMethod autoAdjustHeightLabel:noteLabel labelFontSize:kSmallFont];
        //  更新headerView的高度
        [_communityDetailV.headerView addSubview:noteLabel];
        [_labelArr addObject:noteLabel];
        _communityDetailV.headerView.height = noteLabel.bottom + 10;
    }
    
    if (imgListArr.count > 1) {
        for (int i = 1; i < imgListArr.count; i++) {
            [self addImgBtnLabelWithIndex:i WithImgListArr:imgListArr];
        }
    }
    _communityDetailV.tableView.tableHeaderView = _communityDetailV.headerView;
}


- (void)addImgBtnLabelWithIndex:(NSInteger)index WithImgListArr:(NSArray *)imgListArr
{
    NSDictionary *imgDic = imgListArr[index];
    NSString *width = imgDic[@"width"];
    NSString *height = imgDic[@"height"];
    UILabel *lastNotelabel = (UILabel *)_labelArr[index - 1];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, lastNotelabel.bottom + 10, kScreenWidth - 20, (kScreenWidth - 20) * height.floatValue / width.floatValue);
    NSString *urlStr = imgDic[@"url"];
    [BMRequestManager downLoadButton:btn UrlString:urlStr];
    
    // 加到上面
    [_communityDetailV.headerView addSubview:btn];
    [_btnArr addObject:btn];
    
    //noteLabel
    UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, btn.bottom + 10, kScreenWidth - 20, 20)];
    noteLabel.numberOfLines = -1;
    noteLabel.font = [UIFont systemFontOfSize:kSmallFont];
    noteLabel.text = imgDic[@"note"];
    [BMCommonMethod autoAdjustHeightLabel:noteLabel labelFontSize:kSmallFont];
    //  更新headerView的高度
    [_communityDetailV.headerView addSubview:noteLabel];
    [_labelArr addObject:noteLabel];
    _communityDetailV.headerView.height = noteLabel.bottom + 10;
}

//  调整时间
- (void)adjustTimeWithStr:(NSString *)timeStr
{
    long long int date1 = (long long int)[timeStr intValue];
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MM-dd HH:mm"];
    
    NSString *str = [formatter stringFromDate:date2];
    
    _communityDetailV.add_time.text = [NSString stringWithFormat:@"%@",str];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
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
