//
//  BMDirectSeedingThirdCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDsLiveAndPreviewModel.h"
@protocol liveButtonDelegate <NSObject>

- (void)popupTimeViewWithModel:(BMDsLiveAndPreviewModel *)model;

@end


@interface BMDirectSeedingThirdCell : UITableViewCell

/*第三个分区的cell*/

@property (nonatomic,assign) id<liveButtonDelegate>delegate;

@property (nonatomic,strong) NSArray *dataArray;

// 集合视图
@property (nonatomic,strong) UICollectionView *collectionView;


@end
