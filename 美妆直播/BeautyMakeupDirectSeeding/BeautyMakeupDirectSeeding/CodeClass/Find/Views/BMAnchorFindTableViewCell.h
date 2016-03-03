//
//  BMAnchorFindTableViewCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMAnchorFindModel.h"

@protocol AnchorFindTableViewCellDelegate <NSObject>

- (void)anchorFindTableViewCellWithModel:(BMAnchorFindModel *)model;


@end

@interface BMAnchorFindTableViewCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *collectionV;


//  接口传解析出来的数组
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, assign) id<AnchorFindTableViewCellDelegate> delegate;
@property (nonatomic, assign) NSInteger index;//  要加载多少个


@end
