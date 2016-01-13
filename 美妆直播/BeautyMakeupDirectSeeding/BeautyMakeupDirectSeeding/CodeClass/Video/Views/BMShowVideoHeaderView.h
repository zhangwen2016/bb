//
//  BMShowVideoHeaderView.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMButtonLabel.h"
#import "BMPersonDetailModel.h"
@interface BMShowVideoHeaderView : UIView
@property (nonatomic, strong) UIButton *avatarButton;
@property (nonatomic, strong) UILabel *course_titleLabel;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UILabel *see_countLabel;

@property (nonatomic, strong) BMButtonLabel *followBL;
@property (nonatomic, strong) BMButtonLabel *pocketBL;
@property (nonatomic, strong) BMButtonLabel *supportBL;

@property (nonatomic, strong) BMPersonDetailModel *personModel;

@end
