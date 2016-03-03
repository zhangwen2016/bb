//
//  BMVideoTeacherListTableViewCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMSearchTeacherModel.h"
@interface BMVideoTeacherListTableViewCell : UITableViewCell
@property (nonatomic,strong) UIButton *avatarButton;//头像
@property (nonatomic,strong) UILabel *nicknameLabel;//昵称
@property (nonatomic,strong) UILabel *auth_textLabel;//老师间接
@property (nonatomic, strong) UILabel *signatureLabel; // 老师签名
@property (nonatomic,strong) UIButton *attentionButton;//关注按钮

@property (nonatomic, strong) BMSearchTeacherModel *teacherModel;

@end
