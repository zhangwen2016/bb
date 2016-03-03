//
//  BMVideoMainTableViewCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMVideoMainModel.h"
#import "BMCommonMethod.h"
@interface BMVideoMainTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *coverImgView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *headerImgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *watchNumberLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) BMVideoMainModel *model;
@property (nonatomic, strong) NSString *timeLabelStatus;
@end
