//
//  BMVideoMainTableViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMVideoMainTableViewCell.h"

@implementation BMVideoMainTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadCellView];
    }
    return self;
}

#pragma mark ----加载界面
- (void)loadCellView{
    _coverImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    [self.contentView addSubview:_coverImgView];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_coverImgView.width - 50, 10, 40, 15)];
    _timeLabel.alpha = 0.5;
    _timeLabel.layer.cornerRadius = 10;
    _titleLabel.numberOfLines = -1;
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




- (void)setModel:(BMVideoMainModel *)model{
    _model = model;
    [BMRequestManager downLoadImageView:_coverImgView UrlString:model.cover_url];
    [BMRequestManager downLoadImageView:_headerImgView UrlString:model.avatar];
    _nameLabel.text = model.nickname;
    _titleLabel.text = model.title;
    _watchNumberLabel.text = [NSString stringWithFormat:@"%@人已观看",model.subscribe_count];
    //_watchNumberLabel自适应宽
    [BMCommonMethod autoAdjustRightWidthLabel:_watchNumberLabel labelFontSize:12];
    
    
    // 更具model的status判断_timeLabel的显示的字是回放还是video_time
    if ([model.status isEqualToString:@"20"]) {
        _timeLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:75 / 255.0 blue:124 / 255.0 alpha:1];
        _timeLabel.text = @"回放";
        _timeLabel.alpha = 1;
    }else if ([model.status isEqualToString:@"1"]){
        _timeLabel.backgroundColor = [UIColor grayColor];
        _timeLabel.text = [NSString stringWithFormat:@" %@ ", model.video_time];
    }else
    {
        _timeLabel.backgroundColor = [UIColor grayColor];
        _timeLabel.text = [NSString stringWithFormat:@" %@ ", model.video_time];
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
