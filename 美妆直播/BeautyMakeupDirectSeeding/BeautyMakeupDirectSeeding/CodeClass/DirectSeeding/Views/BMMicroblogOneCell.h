//
//  BMMicroblogOneCell.h
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/14.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMMicroblogOneCell : UITableViewCell
/*
 微博第一个cell的两个按钮
 */


// 直播按钮
@property (nonatomic,strong) UIButton *Dsbutton;
@property (nonatomic,strong) UIImageView *DsButtonImage;

@property (nonatomic,strong) UIButton *pictureButton;
@property (nonatomic,strong) UIImageView *pictureButtonImage;

@property (nonatomic,strong) UIView *mineDownView;
@property (nonatomic,strong) UIView *maxDownView;

@property (nonatomic,strong) UIView *centreView;


@end
