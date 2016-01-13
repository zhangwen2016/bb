//
//  BMAnchorRankTableViewCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMAnchorRecommendModel.h"

/*
 排行榜的cell
 
 */

@interface BMAnchorRankTableViewCell : UITableViewCell

@property (nonatomic,strong) UIButton *rankNumberBtn;//排行名次
@property (nonatomic,strong) UIButton *avatarButton;//头像
@property (nonatomic,strong) UILabel *nicknameLabel;//昵称
@property (nonatomic,strong) UILabel *subscribe_countLabel;//关注人数
@property (nonatomic,strong) UIButton *attentionButton;//关注按钮
@property (nonatomic, strong) UILabel *signature;//  签名

//  接口model
@property (nonatomic,strong) BMAnchorRecommendModel *model;


@end
