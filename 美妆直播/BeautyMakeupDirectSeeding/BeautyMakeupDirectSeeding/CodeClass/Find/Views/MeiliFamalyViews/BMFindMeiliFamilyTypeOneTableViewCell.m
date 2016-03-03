//
//  BMFindMeiliFamilyTypeOneTableViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMFindMeiliFamilyTypeOneTableViewCell.h"
#import "BMCommonMethod.h"

@implementation BMFindMeiliFamilyTypeOneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubView];
    }
    return self;
}

- (void)addSubView{
    //  活动标题
    _activityTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 20)];
    _activityTitleLabel.numberOfLines = -1;
    _activityTitleLabel.font = [UIFont systemFontOfSize:kLargeFont];
    [self.contentView addSubview:_activityTitleLabel];
    
    //  添加时间
    _addTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_activityTitleLabel.left, _activityTitleLabel.bottom + 10, kScreenWidth / 3, 20)];
    _addTimeLabel.font = [UIFont systemFontOfSize:kSmallFont];
    _addTimeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_addTimeLabel];
    
    //  评论的小图标
    _cmtImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 150, _addTimeLabel.top, 20, _addTimeLabel.height)];
    [self.contentView addSubview:_cmtImgV];
    NSString *cmtPath = [[NSBundle mainBundle] pathForResource:@"MeiliFamilyCmt" ofType:@"png"];
    _cmtImgV.image = [UIImage imageWithContentsOfFile:cmtPath];
    
    //  评论的数量
    _cmtLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cmtImgV.right + 10, _cmtImgV.top, 30, _cmtImgV.height)];
    _cmtLabel.font = [UIFont systemFontOfSize:kSmallFont];
    _cmtLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_cmtLabel];
    
    
    //  浏览的小图标
    _viewCountImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 100, _addTimeLabel.top, 20, _addTimeLabel.height)];
    [self.contentView addSubview:_viewCountImgV];
    NSString *viewPath = [[NSBundle mainBundle] pathForResource:@"meiliFamilyView" ofType:@"png"];
    _viewCountImgV.image = [UIImage imageWithContentsOfFile:viewPath];
    
    //  浏览的数量
    _viewCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(_viewCountImgV.right + 10, _cmtImgV.top, 50, _cmtImgV.height)];
    _viewCountLabel.font = [UIFont systemFontOfSize:kSmallFont];
    _viewCountLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_viewCountLabel];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(BMMeiliFamilyCommunityModel *)model
{
    _model = model;
    _activityTitleLabel.text = model.activity_title;
    [BMCommonMethod autoAdjustHeightLabel:_activityTitleLabel labelFontSize:kLargeFont];
    [self adjustTime];
    _addTimeLabel.top = _activityTitleLabel.bottom + 10;
    _cmtLabel.text = model.cmt_count;
    _viewCountLabel.text = model.view_count;
    
    _cmtLabel.top = _addTimeLabel.top;
    _cmtImgV.top = _addTimeLabel.top;
    _viewCountImgV.top = _addTimeLabel.top;
    _viewCountLabel.top = _addTimeLabel.top;
}

//  调整时间
- (void)adjustTime
{
    long long int date1 = (long long int)[_model.add_time intValue];
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MM-dd HH:mm"];
    
    NSString *str = [formatter stringFromDate:date2];
    
    _addTimeLabel.text = [NSString stringWithFormat:@"%@",str];
}

+ (CGFloat)cellHeightWithModel:(BMMeiliFamilyCommunityModel *)model
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 20)];
    label.numberOfLines = -1;
    label.font = [UIFont systemFontOfSize:kLargeFont];
    label.text = model.activity_title;
    [BMCommonMethod autoAdjustHeightLabel:label labelFontSize:kLargeFont];
    return 50 + label.height;
}


@end
