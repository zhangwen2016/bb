//
//  BMDirectSeedingSecondCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMDirectSeedingSecondCell.h"
#import "UIButton+WebCache.h"

@implementation BMDirectSeedingSecondCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 头像
        _avatarButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _avatarButton.frame = CGRectMake(5, 5, self.contentView.height - 10, self.contentView.height - 10);
    
        _avatarButton.layer.masksToBounds = YES;
        _avatarButton.layer.cornerRadius = _avatarButton.width/2;
        [self.contentView addSubview:_avatarButton];
        
        //昵称
        
        _nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_avatarButton.right + 3, _avatarButton.top, 200, _avatarButton.height / 3 * 2)];
        
        _nicknameLabel.text = @"小Call";
        _nicknameLabel.font = [UIFont systemFontOfSize:kLargeFont];
        [self.contentView addSubview:_nicknameLabel];
        
        //关注人数
        _subscribe_countLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nicknameLabel.left, _nicknameLabel.bottom, _nicknameLabel.width, _avatarButton.height/3)];
        _subscribe_countLabel.font = [UIFont systemFontOfSize:kSmallFont];
        _subscribe_countLabel.text = @"14444人关注";
        _subscribe_countLabel.alpha = 0.5;
        [self.contentView addSubview:_subscribe_countLabel];
        
        // 关注按钮
        
        _attentionButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_attentionButton setTitle:@"+ 关注" forState:(UIControlStateNormal)];
        [_attentionButton setTitleColor:kPinkColor forState:(UIControlStateNormal)];
        
         _attentionButton.frame = CGRectMake(kScreenWidth - 80,self.contentView.height/2 - 15,60, 25);
        _attentionButton.layer.borderWidth = 0.7;
        _attentionButton.layer.borderColor =  kPinkColor.CGColor;
        _attentionButton.layer.cornerRadius = 12;
        
        
        [self.contentView addSubview:_attentionButton];
        
       
    }
    
    return self;
}

- (void)setModel:(BMDsLiveAndPreviewModel *)model
{
    _model = model;
    
    [BMRequestManager downLoadButton:_avatarButton UrlString:model.avatar];
    
    _nicknameLabel.text = model.nickname;
    _subscribe_countLabel.text = [NSString stringWithFormat:@"%@人关注",model.subscribe_count];
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
