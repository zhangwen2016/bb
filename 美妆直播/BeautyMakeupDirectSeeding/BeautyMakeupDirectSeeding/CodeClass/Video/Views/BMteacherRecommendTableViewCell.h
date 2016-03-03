//
//  BMteacherRecommendTableViewCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMButtonLabel.h"
#import "BMRecommendTeacherModel.h"

@protocol BMRecommendTeacherDelegate <NSObject>

- (void)sendButtonModel:(BMRecommendTeacherModel *)model;

@end


@interface BMteacherRecommendTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *teacherArray;
@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, assign) id<BMRecommendTeacherDelegate> delegate;
- (void)removeBgScrollView;

@end
