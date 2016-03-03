//
//  BMAnchorPopularAnchorCollectionViewCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMAnchorRecommendModel.h"

@interface BMAnchorPopularAnchorCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *avatarBtn;

//  接口
@property (nonatomic, strong)BMAnchorRecommendModel *model;

@end
