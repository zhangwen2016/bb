//
//  BMMicroblogSectionHeaderView.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMMicroblogSectionHeaderView.h"

@implementation BMMicroblogSectionHeaderView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = frame.size.width;
        
        CGFloat height = frame.size.height;
        
        _background_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height / 3 * 2)];
        _background_imageView.backgroundColor = [UIColor greenColor];
        [self addSubview:_background_imageView];
        
        
        //创建UIBlurEffect类的实例，并指定某一种毛玻璃效果
        UIBlurEffect *blurEff = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)];
        
        //创建UIVisualEffectView类的实例，将步骤1中的UIBlurEffect类的实例应用到UIVisualEffectView类的实例上
        _visualEffv = [[UIVisualEffectView alloc] initWithEffect:blurEff];
        
        // 设置位置大小跟视图一样
        _visualEffv.frame = CGRectMake(0, 0, _background_imageView.width, _background_imageView.height);
        // 设置透明度
        _visualEffv.alpha = 0.7;
        
        //将UIVisualEffectView类的实例置于待毛玻璃化的视图之上即可
        [self addSubview:_visualEffv];
        
        
        // 头像视图
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, _background_imageView.height - 25, 50, 50)];
        
        
//        _grayView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _background_imageView.width, _background_imageView.height)];
//        _grayView.backgroundColor = [UIColor grayColor];
//        _grayView.alpha = 0.5;
//        [self addSubview:_grayView];
        
        
        
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
