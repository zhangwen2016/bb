//
//  BMAnchorRankTableViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMAnchorRankTableViewCell.h"
#import "BMRequestManager.h"

@implementation BMAnchorRankTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubView];
    }
    return self;
}

- (void)addSubView
{
    
    //  排名
    _rankNumberBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _rankNumberBtn.frame = CGRectMake(10, 10, 50, self.contentView.height - 20);
    [self.contentView addSubview:_rankNumberBtn];
    
    // 头像
    _avatarButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _avatarButton.frame = CGRectMake(_rankNumberBtn.right + 10, _rankNumberBtn.top, 80, 80);
    
    _avatarButton.layer.masksToBounds = YES;
    _avatarButton.layer.cornerRadius = _avatarButton.width/2;
    _avatarButton.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_avatarButton];
    
    //昵称
    _nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_avatarButton.right + 10, _avatarButton.top, kScreenWidth - 100 - _avatarButton.right - 10, 20)];
    
    _nicknameLabel.text = @"小Call";
    _nicknameLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_nicknameLabel];
    
    //  签名
    _signature = [[UILabel alloc] initWithFrame:CGRectMake(_nicknameLabel.left, _nicknameLabel.bottom + 10, _nicknameLabel.width, _nicknameLabel.height)];
    _signature.font = [UIFont systemFontOfSize:kSmallFont];
    [self.contentView addSubview:_signature];
    
    
    //关注人数
    _subscribe_countLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nicknameLabel.left, _signature.bottom + 10, _nicknameLabel.width, _signature.height)];
    _subscribe_countLabel.font = [UIFont systemFontOfSize:12];
    _subscribe_countLabel.text = @"14444人关注";
    _subscribe_countLabel.alpha = 0.5;
    [self.contentView addSubview:_subscribe_countLabel];
    
    // 关注按钮
    _attentionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _attentionButton.frame = CGRectMake(kScreenWidth - 100,self.contentView.height/2 - 15,65, 22);
    [_attentionButton setBackgroundImage:[UIImage imageNamed:@"guanzhu"] forState:(UIControlStateNormal)];
    [_attentionButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_attentionButton];
}

- (void)setModel:(BMAnchorRecommendModel *)model
{
    _model = model;
    [_rankNumberBtn setTitle:model.rank forState:UIControlStateNormal];
    [BMRequestManager downLoadButton:_avatarButton UrlString:model.avatar];
    _nicknameLabel.text = model.nickname;
    _signature.text = model.signature;
    _subscribe_countLabel.text = [NSString stringWithFormat:@"+%@人关注",model.subscribe_count];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
