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
        _background_imageView.image = [UIImage imageNamed:@"zhanweitu.jpg"];
        [self addSubview:_background_imageView];
        
        
        
        //创建UIBlurEffect类的实例，并指定某一种毛玻璃效果
        UIBlurEffect *blurEff = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)];
        
        //创建UIVisualEffectView类的实例，将步骤1中的UIBlurEffect类的实例应用到UIVisualEffectView类的实例上
        _visualEffv = [[UIVisualEffectView alloc] initWithEffect:blurEff];
        
        // 设置位置大小跟视图一样
        _visualEffv.frame = CGRectMake(0, 0, _background_imageView.width, _background_imageView.height);
        // 设置透明度
        _visualEffv.alpha = 0.2;
        
        //将UIVisualEffectView类的实例置于待毛玻璃化的视图之上即可
        [self addSubview:_visualEffv];
        
        
        // 头像视图
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, height/3 * 2 - 50, 80, 80)];
        
        _avatarImageView.backgroundColor = [UIColor yellowColor];
        
        _avatarImageView.layer.cornerRadius = 40;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.borderWidth = 2;
        
        _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:_avatarImageView];
        
        //中间的竖线
        _View = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2, _avatarImageView.top + 10, 2, 50 - 20)];
        _View.alpha = 0.5;
        _View.backgroundColor = [UIColor whiteColor];
        [self addSubview:_View];
        
        
        // 粉丝
        _fansLabel = [[UILabel alloc] initWithFrame:CGRectMake(_View.left - 60, _avatarImageView.top, 50, 25)];
        _fansLabel.text = @"粉丝";
        _fansLabel.textAlignment = NSTextAlignmentCenter;
        _fansLabel.font = [UIFont systemFontOfSize:kSmallFont];
        _fansLabel.alpha = 0.5;
        _fansLabel.textColor = [UIColor whiteColor];
        [self addSubview:_fansLabel];
        // 收益
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(_View.left + 10, _avatarImageView.top, 50, 25)];
        _moneyLabel.text = @"收益";
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.alpha = 0.5;

        _moneyLabel.font = [UIFont systemFontOfSize:kSmallFont];
        _moneyLabel.textColor = [UIColor whiteColor];
        [self addSubview:_moneyLabel];
        
        // 粉丝数量
        _fans_countLabel = [[UILabel alloc] initWithFrame:CGRectMake(_fansLabel.left, _fansLabel.bottom, _fansLabel.width, _fansLabel.height)];
        _fans_countLabel.textColor = [UIColor whiteColor];
        _fans_countLabel.text = @"3280人";
        _fans_countLabel.alpha = 0.5;

        _fans_countLabel.textAlignment = NSTextAlignmentCenter;
        _fans_countLabel.font = [UIFont systemFontOfSize:kSmallFont];
        [self addSubview:_fans_countLabel];
        
        // 收益数
        _money_countLabel = [[UILabel alloc] initWithFrame:CGRectMake(_moneyLabel.left, _moneyLabel.bottom, _moneyLabel.width, _moneyLabel.height)];
        _money_countLabel.textColor = [UIColor whiteColor];
        _money_countLabel.text = @"575元";
        _money_countLabel.textAlignment = NSTextAlignmentCenter;
        _money_countLabel.font = [UIFont systemFontOfSize:kSmallFont];
        _money_countLabel.alpha = 0.5;
        [self addSubview:_money_countLabel];
        
        // 关注按钮
        _attentionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _attentionButton.frame = CGRectMake(kScreenWidth - 100, _moneyLabel.top + 5, 90, 35);
        _attentionButton.alpha = 0.5;
        [_attentionButton setBackgroundImage:[UIImage imageNamed:@"guanzhu01"] forState:(UIControlStateNormal)];
        [self addSubview:_attentionButton];
        
        // 签约主播
        _auth_textLabel = [[UILabel alloc] initWithFrame:CGRectMake(_avatarImageView.right + 5, _background_imageView.bottom, 100, 30)];
        _auth_textLabel.textColor = [UIColor grayColor];
        _auth_textLabel.text = @"美狸签约主播";
        _auth_textLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_auth_textLabel];
        
        // 个性签名
        _signatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(_avatarImageView.left, _avatarImageView.bottom, 200, 25)];
        _signatureLabel.textColor = [UIColor grayColor];
        _signatureLabel.text = @"干皮,愛彩妆";
        _signatureLabel.font = [UIFont systemFontOfSize:kSmallFont];
        [self addSubview:_signatureLabel];
        
    }
    
    return self;
}


- (void)setModel:(BMMicroblogModel *)model
{
    _model = model;
    [_background_imageView sd_setImageWithURL:[NSURL URLWithString:model.background_image] placeholderImage:[UIImage imageNamed:@"zhanweitu.jpg"]];
    
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    
    _fans_countLabel.text = model.fans_count;
    _money_countLabel.text = model.money_count;
    _auth_textLabel.text = model.auth_text;
    _signatureLabel.text = model.signature;
     
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
