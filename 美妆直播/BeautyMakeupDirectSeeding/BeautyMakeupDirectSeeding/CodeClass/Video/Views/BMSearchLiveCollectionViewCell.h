//
//  BMSearchLiveCollectionViewCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMSearchTeacherModel.h"
@interface BMSearchLiveCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) BMSearchTeacherModel *teacherModel;
@property (nonatomic, strong) UIImageView *live_coverImg;
@property (nonatomic, strong) UILabel *live_titleLabel;

@end
