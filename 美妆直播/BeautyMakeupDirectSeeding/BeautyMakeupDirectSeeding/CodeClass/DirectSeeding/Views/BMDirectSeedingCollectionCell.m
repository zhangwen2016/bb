//
//  BMDirectSeedingCollectionVC.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMDirectSeedingCollectionCell.h"
#import "UIButton+WebCache.h"

@implementation BMDirectSeedingCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        // 预告图片
        _live_coverButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _live_coverButton.frame = CGRectMake(0, 0, width, height/3 * 2);
        _live_coverButton.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_live_coverButton];
        
        // 开播时间
        _start_timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _live_coverButton.height - 15, _live_coverButton.width, 15)];
        _start_timeLabel.backgroundColor = [UIColor grayColor];
        _start_timeLabel.textColor = [UIColor whiteColor];
        _start_timeLabel.font = [UIFont systemFontOfSize:12];
        _start_timeLabel.alpha = 0.7;
        _start_timeLabel.textAlignment = NSTextAlignmentCenter;
        _start_timeLabel.text = @"01-12 19:30";
        [_live_coverButton addSubview:_start_timeLabel];
        
        // 标题
        _live_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _live_coverButton.bottom, _live_coverButton.width - 5, height / 9 * 2)];
        _live_titleLabel.font = [UIFont systemFontOfSize:16];
        _live_titleLabel.text = @"海归购物计划";
        [self.contentView addSubview:_live_titleLabel];
        
        
        // 昵称
        _nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_live_titleLabel.left, _live_titleLabel.bottom, _live_titleLabel.width, height / 9)];
        _nicknameLabel.text = @"kimiko心仪";
        _nicknameLabel.font = [UIFont systemFontOfSize:12];
        _nicknameLabel.alpha = 0.5;
        [self.contentView addSubview:_nicknameLabel];
        
    }
    return self;
}
- (void)setModel:(BMDsLiveAndPreviewModel *)model
{
    _model = model;
    [_live_coverButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.live_cover] forState:(UIControlStateNormal)];
    
    
    long long int date1 = (long long int)[model.start_time intValue];
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MM-dd日 HH:mm"];
    NSString *str = [formatter stringFromDate:date2];
    
    _start_timeLabel.text = [NSString stringWithFormat:@"%@开播",str];
    
    _live_titleLabel.text = model.live_title;
    _nicknameLabel.text = model.nickname;
    
    
}


@end
