//
//  BMMeiiFamilyCommentTableViewCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMMeiliFamilyCmtModel.h"

@interface BMMeiiFamilyCommentTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatarImgV;//  头像
@property (nonatomic, strong) UILabel *nicknameLable;//  昵称
@property (nonatomic, strong) UILabel *add_time;//  发布时间
@property (nonatomic, strong) UILabel *coment_level;//  楼层
@property (nonatomic, strong) UILabel *comment_content;//  介绍

@property (nonatomic, strong) UIImageView *cmtPic;//  评论的照片

@property (nonatomic, strong) UIView *parentView;//  父级评论的背景

@property (nonatomic, strong) UILabel *parent_nickname;//  父级评论人
@property (nonatomic, strong) UILabel *parent_cmt;// 父级评论

@property (nonatomic, strong) UIButton *cmtBtn;//  评论按钮


@property (nonatomic, strong) BMMeiliFamilyCmtModel *model;//  接口


+ (CGFloat)heightForCellWithModel:(BMMeiliFamilyCmtModel *)model;

@end
