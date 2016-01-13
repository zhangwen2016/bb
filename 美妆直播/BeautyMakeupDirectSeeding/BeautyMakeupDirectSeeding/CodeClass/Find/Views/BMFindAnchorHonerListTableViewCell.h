//
//  BMFindAnchorHonerListTableViewCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMAnchorRecommendModel.h"

@interface BMFindAnchorHonerListTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *logoImg;//  放前面的小王冠或者钱袋的logo
@property (nonatomic, strong)UILabel *titleLable;//  标题lable

//  三个头像
@property (nonatomic, strong)UIImageView *firstAvatarImg;
@property (nonatomic, strong)UIImageView *secondAvatarImg;
@property (nonatomic, strong)UIImageView *thirdAvatarImg;

//  接口
@property (nonatomic, strong)NSArray *dataArr;

@end
