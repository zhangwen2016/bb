//
//  BMShowVideoHeaderView.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMShowVideoHeaderView.h"
#import "BMMicroblogVC.h"
@implementation BMShowVideoHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:244 / 255.0 alpha:1];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height / 2)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        
        _avatarButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _avatarButton.frame = CGRectMake(10, 10, 50, 50);
        _avatarButton.layer.cornerRadius = 25;
        _avatarButton.layer.masksToBounds = YES;
       // _avatarButton.backgroundColor = [UIColor orangeColor];
        [_avatarButton addTarget:self action:@selector(avatarButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [bgView addSubview:_avatarButton];
        
        _course_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_avatarButton.right, _avatarButton.top, 300, 20)];
        _course_titleLabel.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:_course_titleLabel];
        
        _nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_avatarButton.right, _course_titleLabel.bottom + 15, 200, 15)];
        _nicknameLabel.textColor = [UIColor grayColor];
        _nicknameLabel.font = [UIFont systemFontOfSize:10];
        [bgView addSubview:_nicknameLabel];
        
        _see_countLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 50, _nicknameLabel.top, 40, _nicknameLabel.height)];
        _see_countLabel.textColor = [UIColor grayColor];
        _see_countLabel.font = [UIFont systemFontOfSize:10];
        [bgView addSubview:_see_countLabel];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_see_countLabel.left - 20, _see_countLabel.top, 15, 15)];
        imageView.image = [UIImage imageNamed:@"meiliFamilyView.png"];
        [bgView addSubview:imageView];
        
        for (int i = 0; i < 3; i++) {
            CGFloat width = ([UIScreen mainScreen].bounds.size.width - 10) / 3;
            CGFloat height = frame.size.height / 2 - 20;
            BMButtonLabel *bl = [[BMButtonLabel alloc] initWithFrame:CGRectMake(0 + (5 + width) * i, frame.size.height / 2 + 10, width, height)];
            bl.tag = i + 100;
            [self addSubview:bl];
        }
        
        _followBL = [self viewWithTag:100];
        _pocketBL = [self viewWithTag:101];
        _supportBL = [self viewWithTag:102];
    }
    return self;
}

- (void)setPersonModel:(BMPersonDetailModel *)personModel{
    _personModel = personModel;
    
    [BMRequestManager downLoadButton:_avatarButton UrlString:personModel.avatar];
    _course_titleLabel.text = personModel.course_title;
    _nicknameLabel.text = personModel.nickname;
    _see_countLabel.text = personModel.see_count;
    _followBL.downLabel.text = [personModel.subscribe_count stringByAppendingString:@"人已关注"];
    _pocketBL.downLabel.text = [NSString stringWithFormat:@"已获得红包%@元",personModel.wallet_number];
    _supportBL.downLabel.text = [NSString stringWithFormat:@"已有%@人点赞", personModel.praise_count];
    
    if ([personModel.is_subscribe intValue] == 0) {
        [_followBL.upButton setTitle:@"+ 关注" forState:(UIControlStateNormal)];
    }else{
         [_followBL.upButton setTitle:@"已经关注" forState:(UIControlStateNormal)];
    }
    
    if ([personModel.is_praise intValue] == 0) {
        [_pocketBL.upButton setTitle:@"送红包" forState:(UIControlStateNormal)];
    }else{
        [_pocketBL.upButton setTitle:@"已送红包" forState:(UIControlStateNormal)];
        
    }
    if ([personModel.is_favorite intValue] == 0) {
        [_supportBL.upButton setTitle:@"点赞" forState:(UIControlStateNormal)];
    }else{
        [_supportBL.upButton setTitle:@"已赞" forState:(UIControlStateNormal)];
    }
}

- (void)avatarButtonClick:(UIButton *)button{
    // NSLog(@"avatarButtonClick");
    BMMicroblogVC *blogVC = [[BMMicroblogVC alloc] init];
    blogVC.uid = _personModel.uid;
    [_currentVC.navigationController pushViewController:blogVC animated:YES];
   
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
