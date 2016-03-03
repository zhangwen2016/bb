//
//  BMMicroblogCollectionCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/14.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMMicroblogModel.h"
@interface BMMicroblogCollectionCell : UICollectionViewCell
/*微博集合视图cell*/

@property (nonatomic,strong) UIButton *img_urlButton;
@property (nonatomic,strong) BMMicroblogModel *model;
@end
