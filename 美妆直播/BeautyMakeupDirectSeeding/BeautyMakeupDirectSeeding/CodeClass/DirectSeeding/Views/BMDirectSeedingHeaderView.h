//
//  BMDirectSeedingHeaderView.h
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol headerViewDelegate <NSObject>

- (void)transmitWithID:(NSString *)ID;

@end

@interface BMDirectSeedingHeaderView : UIView

@property (nonatomic,strong) id<headerViewDelegate>delegate;

@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,strong) NSMutableArray *ImageUrlArray;

@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,assign)BOOL isFirst;//标记定时器方法是否是第一次




@end
