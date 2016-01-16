//
//  BMDirectSeedingFirstCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMDirectSeedingFirstCell.h"
#import "BMRequestManager.h"
#import "BMCommonMethod.h"
@implementation BMDirectSeedingFirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self loadCellView];
    }
    
    return self;
}

- (void)loadCellView{
    _coverImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    [self.contentView addSubview:_coverImgView];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_coverImgView.width - 70, 10, 60, 20)];
    _timeLabel.alpha = 0.5;
    _timeLabel.layer.cornerRadius = 10;
    _titleLabel.numberOfLines = -1;
    _timeLabel.backgroundColor = [UIColor magentaColor];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    [_coverImgView addSubview:_timeLabel];
    
    
    _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, _coverImgView.bottom - 25, 50, 50)];
    _headerImgView.layer.cornerRadius = 25;
    _headerImgView.layer.masksToBounds = YES;
    _headerImgView.layer.borderWidth = 1;
    _headerImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.contentView addSubview:_headerImgView];
    
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headerImgView.right, _coverImgView.bottom + 5, 80, 20)];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_nameLabel];
    
    
    _watchNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, _nameLabel.top, 90, 20)];
    _watchNumberLabel.textColor = [UIColor colorWithRed:255/255.0 green:75 / 255.0 blue:124 / 255.0 alpha:1];
    _watchNumberLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_watchNumberLabel];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headerImgView.left, _nameLabel.bottom + 10, [UIScreen mainScreen].bounds.size.width, 25)];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_titleLabel];
}

- (void)setModel:(BMDsLiveAndPreviewModel *)model{
    _model = model;
    
    [BMRequestManager downLoadImageView:_coverImgView UrlString:model.live_cover];
    [BMRequestManager downLoadImageView:_headerImgView UrlString:model.avatar];
    _nameLabel.text = model.nickname;
    _titleLabel.text = model.live_title;
    _watchNumberLabel.text = [NSString stringWithFormat:@"%@人已订阅",model.subscribe_count];
    
    
    long long int date1 = (long long int)[model.start_time intValue];
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *str = [formatter stringFromDate:date2];
    
    _timeLabel.text = [NSString stringWithFormat:@"%@开播",str];
    
    if ([model.status isEqualToString:@"10"]) {
        
        _watchNumberLabel.text = [NSString stringWithFormat:@"%@人/目前%@人",model.view_count,model.online_count];
        
        CGRect timeFrame = _timeLabel.frame;
        timeFrame.size.width =  40;
        _timeLabel.frame = timeFrame;
         _timeLabel.text = @"直播中";
        
        CGRect watchNumberFrame = _watchNumberLabel.frame;
        watchNumberFrame.size.width = 120;
        watchNumberFrame.origin.x = kScreenWidth - 130;
        _watchNumberLabel.frame = watchNumberFrame;
        
        
    }
    
    
}

- (void)setMicroblogModel:(BMDsLiveAndPreviewModel *)microblogModel
{
    _microblogModel = microblogModel;
//    [BMRequestManager downLoadImageView:_coverImgView UrlString:microblogModel.cover_url];
//    
//    long long int date1 = (long long int)[microblogModel.start_time intValue];
//    
//    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"HH:mm"];
//    NSString *str = [formatter stringFromDate:date2];
//    
//    _timeLabel.text = [NSString stringWithFormat:@"%@开播",str];
//    
    
    [BMRequestManager downLoadImageView:_coverImgView UrlString:microblogModel.cover_url];
    [BMRequestManager downLoadImageView:_headerImgView UrlString:microblogModel.avatar];
    _nameLabel.text = microblogModel.nickname;
    _titleLabel.text = microblogModel.title;
    _watchNumberLabel.text = [NSString stringWithFormat:@"%@人已观看",microblogModel.subscribe_count];
    //_watchNumberLabel自适应宽
    [BMCommonMethod autoAdjustRightWidthLabel:_watchNumberLabel labelFontSize:12];
    
    
    // 更具model的status判断_timeLabel的显示的字是回放还是video_time
    if ([microblogModel.status isEqualToString:@"20"]) {
        _timeLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:75 / 255.0 blue:124 / 255.0 alpha:1];
        _timeLabel.text = @"回放";
        _timeLabel.alpha = 1;
    }else if ([microblogModel.status isEqualToString:@"1"]){
        _timeLabel.backgroundColor = [UIColor grayColor];
        _timeLabel.text = [NSString stringWithFormat:@" %@ ", microblogModel.video_time];
    }
    
    if ([microblogModel.status isEqualToString:@"3"]) {
        
        long long int date1 = (long long int)[microblogModel.start_time intValue];
        
        NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        NSString *str = [formatter stringFromDate:date2];
        
        _timeLabel.text = [NSString stringWithFormat:@"%@开播",str];
        
        
    }
    
    // _timeLable设置自适应自适应宽度
    [BMCommonMethod autoAdjustRightWidthLabel:_timeLabel labelFontSize:12];

    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
