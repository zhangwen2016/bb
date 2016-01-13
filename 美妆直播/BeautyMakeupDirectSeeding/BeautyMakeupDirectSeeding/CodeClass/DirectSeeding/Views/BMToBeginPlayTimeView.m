//
//  BMToBeginPlayTimeView.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMToBeginPlayTimeView.h"

@implementation BMToBeginPlayTimeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        // 离开播时间的背景
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height / 5)];
        _headerView.backgroundColor = [UIColor magentaColor];
        [self addSubview:_headerView];
        
        // 关闭按钮
        _closeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _closeButton.frame = CGRectMake(_headerView.width - (_headerView.height/2), 10, _headerView.height/3, _headerView.height/6);
        [_closeButton setTitle:@"X" forState:(UIControlStateNormal)];
        [self addSubview:_closeButton];
        
        // 离开播
        _playLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, width, _headerView.height / 3 - 5)];
        _playLabel.textColor = [UIColor whiteColor];
        _playLabel.text = @"离开播";
        _playLabel.textAlignment = NSTextAlignmentCenter;
        _playLabel.font = [UIFont systemFontOfSize:kSmallFont];
        [self addSubview:_playLabel];
        
        // 开播时间
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,_playLabel.bottom + 5,_headerView.width,(_headerView.height / 3 * 2) - 10)];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:kLargeFont];
        _timeLabel.text = @"07:06:03";
        [self addSubview:_timeLabel];
        
        //头像按钮
        _avatarButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        _avatarButton.frame = CGRectMake((width - (height/5))/2,height/5 + 5 , height/5, height/5);
        _avatarButton.layer.masksToBounds = YES;
        _avatarButton.layer.cornerRadius = _avatarButton.width/2;
        _avatarButton.backgroundColor = [UIColor magentaColor];
        [self addSubview:_avatarButton];
        
        
        //昵称
        _nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height/5*2 + 10, width, height/6)];
        _nicknameLabel.text = @"梦露";
        _nicknameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nicknameLabel];
        
        // 一键提醒
        _remindButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _remindButton.frame = CGRectMake((width - (width - 40))/2, height/5*3 + 10 , width - 40, height /6);
        [_remindButton setTitle:@"一键提醒" forState:(UIControlStateNormal)];
         [_remindButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self addSubview:_remindButton];
        
        // 分享
        _shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _shareButton.frame = CGRectMake(_remindButton.left,height/5*4, _remindButton.width, _remindButton.height);
        [_shareButton setTitle:@"分享" forState:(UIControlStateNormal)];
        [_shareButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self addSubview:_shareButton];
        
        
//        _shareButton.backgroundColor = [UIColor magentaColor];
//        _remindButton.backgroundColor = [UIColor magentaColor];
//        _nicknameLabel.backgroundColor = [UIColor magentaColor];
//        self.autoresizesSubviews = YES;
//        
//        _headerView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        _closeButton.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        _playLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        _timeLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        _avatarButton.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        _nicknameLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//         _remindButton.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        
//         _shareButton.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        
        
        
    }
    return self;
}


- (void)setModel:(BMDsLiveAndPreviewModel *)model
{
    _model = model;
    
    [_avatarButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.avatar] forState:(UIControlStateNormal)];
    _nicknameLabel.text = model.nickname;
    
    
    _data = (long long int)[model.start_time intValue];
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    
    long long int date = (long long int)time;

    // 当前时间 - 开始时间
     _data = _data - date;
    
    NSLog(@"%lld",_data);
    
    if ([model.status isEqualToString:@"3"]&& _data > 3600 * 24) {
        _timeLabel.text = @"一天以上";
        
    }else if ([model.status isEqualToString:@"3"] && _data > 0){
        
        _data = _data - 8 * 3600;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_data];

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

        [formatter setDateFormat:@"HH:mm:ss"];
        NSString *str = [formatter stringFromDate:date];
        _timeLabel.text = str;
        
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
        
    }
    
    
}


- (void)timer:(NSTimer *)timer
{
    _data--;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_data];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *str = [formatter stringFromDate:date];
    _timeLabel.text = str;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
