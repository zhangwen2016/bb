//
//  BMFindMeiliFamilyTypeTwoTableViewCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMMeiliFamilyCommunityModel.h"


@interface BMFindMeiliFamilyTypeTwoTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *activityTitleLabel;//  活动标题
@property (nonatomic, strong) UILabel *addTimeLabel;//  发布时间
@property (nonatomic, strong) UIImageView *cmtImgV;//  评论图片
@property (nonatomic, strong) UILabel *cmtLabel;//  评论数目
@property (nonatomic, strong) UIImageView *viewCountImgV;//  浏览图标
@property (nonatomic, strong) UILabel *viewCountLabel;//  浏览数目

//  三个图片
@property (nonatomic, strong) UIImageView *firstImgV;
@property (nonatomic, strong) UIImageView *secondImgV;
@property (nonatomic, strong) UIImageView *thirdImgV;

+ (CGFloat)cellHeightWithModel:(BMMeiliFamilyCommunityModel *)model;



//  接口
@property (nonatomic, strong)BMMeiliFamilyCommunityModel *model;

@end
