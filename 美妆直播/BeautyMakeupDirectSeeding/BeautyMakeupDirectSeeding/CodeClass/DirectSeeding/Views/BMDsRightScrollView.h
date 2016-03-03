//
//  BMDsRightScrollView.h
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMDsRightScrollView : UIScrollView

/*
 直播右边视图的自定义View
 */

@property (nonatomic,strong) UILabel * titleLabel;// 你现在
@property (nonatomic,strong) UILabel *titleLabel1;

@property (nonatomic,strong) UIButton *avatarButton1;

@property (nonatomic,strong) UIButton *avatarButton2;

@property (nonatomic,strong) UIButton *avatarButton3;

@property (nonatomic,strong) UIButton *avatarButton4;

@property (nonatomic,strong) UIButton *avatarButton5;

@property (nonatomic,strong) UIButton *avatarButton6;

@property (nonatomic,strong) UIButton *avatarButton7;

@property (nonatomic,strong) UIButton *avatarButton8;


@property (nonatomic,strong) UILabel *nicknameLabel1;

@property (nonatomic,strong) UILabel *nicknameLabel2;

@property (nonatomic,strong) UILabel *nicknameLabel3;

@property (nonatomic,strong) UILabel *nicknameLabel4;

@property (nonatomic,strong) UILabel *nicknameLabel5;

@property (nonatomic,strong) UILabel *nicknameLabel6;

@property (nonatomic,strong) UILabel *nicknameLabel7;

@property (nonatomic,strong) UILabel *nicknameLabel8;


// 关注按钮
@property (nonatomic,strong) UIButton *attentionButton;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end
