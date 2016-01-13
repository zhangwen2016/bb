//
//  BMDirectSeedingRightVC.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMDirectSeedingRightVC.h"
#import "BMDsRightScrollView.h"
#import "BMDsLiveAndPreviewModel.h"


#define kDsRightVCUrl @"http://app.meilihuli.com/api/channel/recommendteacher/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8http://app.meilihuli.com/api/channel/recommendteacher/?lang=zh-cn&version=ios2.0.0&cid=asXoHoWV7R9iVVx6r8CwK8"

@interface BMDirectSeedingRightVC ()

@property (nonatomic,strong) BMDsRightScrollView *rightVC;

@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation BMDirectSeedingRightVC

- (void)loadView{
    [super loadView];
    
    BMDsRightScrollView *rightView = [[BMDsRightScrollView alloc] initWithFrame:self.view.bounds];
    rightView.bounces = YES;
    rightView.alwaysBounceVertical = YES;
    self.view = rightView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _rightVC = (BMDsRightScrollView *)self.view;
    _dataArray = [NSMutableArray array];
    [self setUpData];
}

// 数据加载
- (void)setUpData
{
    
    // 请求数据
    [BMRequestManager requsetWithUrlString:kDsRightVCUrl parDic:nil Method:GET finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"data"];
        for (NSDictionary *oneDic in array) {
            BMDsLiveAndPreviewModel *model = [[BMDsLiveAndPreviewModel alloc] init];
            
            [model setValuesForKeysWithDictionary:oneDic];
            [_dataArray addObject:model];
            
        }
        
        _rightVC.dataArray = _dataArray;
        
        
    } erro:^(NSError *erro) {
        NSLog(@"请求失败");
    }];
    
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
