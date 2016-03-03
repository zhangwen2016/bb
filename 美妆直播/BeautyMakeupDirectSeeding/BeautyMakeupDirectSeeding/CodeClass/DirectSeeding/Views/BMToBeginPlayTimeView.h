//
//  BMToBeginPlayTimeView.h
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDsLiveAndPreviewModel.h"
@interface BMToBeginPlayTimeView : UIView
/*
 自定义离开始直播时间
*/


@property (nonatomic,strong) UIView *headerView;// 离开播时间的背景

@property (nonatomic,strong) UIButton *closeButton;// 关闭按钮

@property (nonatomic,strong) UILabel *playLabel;//离开播

@property (nonatomic,strong) UILabel *timeLabel;// 显示时间

@property (nonatomic,strong) UIButton *avatarButton;//头像按钮

@property (nonatomic,strong) UILabel *nicknameLabel;//昵称

@property (nonatomic,strong) UIButton *remindButton;//提醒按钮

@property (nonatomic,strong) UIButton *shareButton;//分享按钮

@property (nonatomic,strong) BMDsLiveAndPreviewModel *model;

@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,assign) long long int data;

@end
