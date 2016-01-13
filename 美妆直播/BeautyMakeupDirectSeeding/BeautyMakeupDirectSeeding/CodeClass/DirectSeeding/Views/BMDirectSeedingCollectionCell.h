//
//  BMDirectSeedingCollectionVC.h
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMDsLiveAndPreviewModel.h"

@interface BMDirectSeedingCollectionCell : UICollectionViewCell

/*
 自定义集合视图的cell
 */

// 预告图片
@property (nonatomic,strong) UIButton *live_coverButton;

// 开播时间
@property (nonatomic,strong) UILabel *start_timeLabel;

// 标题
@property (nonatomic,strong) UILabel *live_titleLabel;

// 昵称
@property (nonatomic,strong) UILabel *nicknameLabel;

@property (nonatomic,strong) BMDsLiveAndPreviewModel *model;


@end
