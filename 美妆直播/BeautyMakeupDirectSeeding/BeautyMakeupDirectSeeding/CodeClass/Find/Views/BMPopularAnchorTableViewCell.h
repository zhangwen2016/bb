//
//  BMPopularAnchorTableViewCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMAnchorRecommendModel.h"

@protocol BMPopularAnchorTableViewCellDelegate <NSObject>

- (void)popularAnchorTableViewCellBringModel:(BMAnchorRecommendModel *)model;

@end

@interface BMPopularAnchorTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *dataArr;
//  申请成为主播的btn  方便到controller里面实现点击实现方法
@property (nonatomic, strong) UIButton *applyAnchor;

//  代理
@property (nonatomic, assign) id<BMPopularAnchorTableViewCellDelegate>delegate;

@end
