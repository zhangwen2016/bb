//
//  BMMicroblogSectionHeaderView.h
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMMicroblogSectionHeaderView : UIView

/*
 微博的表头View
 */

@property (nonatomic,strong) UIImageView *background_imageView;// 背景图片

// 毛玻璃
@property (nonatomic,strong) UIVisualEffectView *visualEffv;

@property (nonatomic,strong) UIImageView *grayView;// 背景上的灰色

// 头像View
@property (nonatomic,strong) UIImageView *avatarImageView;

// 粉丝人数
@property (nonatomic,strong) UILabel *fansLabel;
@property (nonatomic,strong) UILabel *fans_countLabel;

// 中间的竖线
@property (nonatomic,strong) UIView *View;

// 收益
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *money_countLabel;

// 关注按钮
@property (nonatomic,strong) UIButton *attentionButton;

// 签约主播
@property (nonatomic,strong) UILabel *auth_textLabel;

// 个性签名
@property (nonatomic,strong) UILabel *signatureLabel;

// 星星
@property (nonatomic,strong) UIImageView *gradeImageV;


@end
