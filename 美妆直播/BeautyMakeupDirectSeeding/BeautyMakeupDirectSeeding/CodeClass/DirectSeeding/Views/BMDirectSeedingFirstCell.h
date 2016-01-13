//
//  BMDirectSeedingFirstCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDsLiveAndPreviewModel.h"
@interface BMDirectSeedingFirstCell : UITableViewCell

/*
 第一个分区的Cell
 */

@property (nonatomic, strong) UIImageView *coverImgView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *headerImgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *watchNumberLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSString *timeLabelStatus;

@property (nonatomic, strong) BMDsLiveAndPreviewModel *model;


@end
