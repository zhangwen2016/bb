//
//  BMAnchorPopularAnchorCollectionViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMAnchorPopularAnchorCollectionViewCell.h"
#import "BMRequestManager.h"

@interface BMAnchorPopularAnchorCollectionViewCell ()

@property (nonatomic, strong) UIButton *avatarBtn;
@property (nonatomic, strong) UILabel *nicknameLabel;

@end

@implementation BMAnchorPopularAnchorCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _avatarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _avatarBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.width);
        [self.contentView addSubview:_avatarBtn];
        
        _nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _avatarBtn.bottom + 5, _avatarBtn.width, 25)];
        [self.contentView addSubview:_nicknameLabel];
    }
    return self;
}

- (void)setModel:(BMAnchorRecommendModel *)model
{
    _model = model;
    [BMRequestManager downLoadButton:_avatarBtn UrlString:model.avatar];
    _avatarBtn.layer.cornerRadius = _avatarBtn.frame.size.width / 2;
    _avatarBtn.layer.masksToBounds = YES;
    [_avatarBtn addTarget:self action:@selector(clickPopularAchor:) forControlEvents:UIControlEventTouchUpInside];
    _nicknameLabel.text = model.nickname;
    _nicknameLabel.font = [UIFont systemFontOfSize:kSmallFont];
    _nicknameLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark  点击分组里的每个主播跳转到下一页
- (void)clickPopularAchor:(UIButton *)sender
{
    NSLog(@"点击了btn");
}

@end
