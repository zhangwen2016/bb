//
//  BMVideoLiveTableViewCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMSearchTeacherModel.h"
@interface BMVideoLiveTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *liveCollectionView;
@property (nonatomic, strong) NSArray *liveArray;

@property (nonatomic, strong) UIViewController *currentVC;
@end
