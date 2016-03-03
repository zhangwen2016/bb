//
//  BMDirectSeedingSecondCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDsLiveAndPreviewModel.h"

@protocol SecondCellDelegate <NSObject>

- (void)transmitWithUid:(NSString *)uid;

@end


@interface BMDirectSeedingSecondCell : UITableViewCell

/*
 第二个分区cell
 大家都在关注的cell;
 
 */

@property (nonatomic,assign) id<SecondCellDelegate>delegate;
@property (nonatomic,strong) UIButton *avatarButton;//头像
@property (nonatomic,strong) UILabel *nicknameLabel;//昵称
@property (nonatomic,strong) UILabel *subscribe_countLabel;//关注人数
@property (nonatomic,strong) UIButton *attentionButton;//关注按钮
@property (nonatomic, strong) BMDsLiveAndPreviewModel *model;



@end
