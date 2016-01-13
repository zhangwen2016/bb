//
//  BMVideoTeacherListTableViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMVideoTeacherListTableViewCell.h"

@implementation BMVideoTeacherListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubView];
    }
    return self;
}

- (void)loadSubView{
    // 头像
    _avatarButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _avatarButton.frame = CGRectMake(5, 10, 40, 40);
    _avatarButton.layer.masksToBounds = YES;
    _avatarButton.layer.cornerRadius = 20;
    _avatarButton.layer.borderWidth = 1;
    _avatarButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_avatarButton setBackgroundImage:[UIImage imageNamed:@"mine.png"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_avatarButton];
    
    //昵称
    _nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_avatarButton.right + 3, 5, 200, self.contentView.height / 3 * 1)];
    _nicknameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_nicknameLabel];
    
    //老师间接
    _auth_textLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nicknameLabel.left, _nicknameLabel.bottom + 2, _nicknameLabel.width, _nicknameLabel.height)];
    _auth_textLabel.font = [UIFont systemFontOfSize:12];
    _auth_textLabel.textColor = [UIColor grayColor];
    _auth_textLabel.alpha = 0.5;
    [self.contentView addSubview:_auth_textLabel];
    
    // 老师签名
    _signatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nicknameLabel.left, _auth_textLabel.bottom + 2, 250, _auth_textLabel.height)];
    _signatureLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_signatureLabel];
    
    
    // 关注按钮
    _attentionButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _attentionButton.frame = CGRectMake(kScreenWidth - 60,self.contentView.height/2 - 5,50, 22);
    _attentionButton.layer.borderWidth = 0.5;
    
    _attentionButton.layer.cornerRadius = 10;
    
    [self.contentView addSubview:_attentionButton];
    
}

- (void)setTeacherModel:(BMSearchTeacherModel *)teacherModel{
    _teacherModel = teacherModel;
    [BMRequestManager downLoadButton:_avatarButton UrlString:teacherModel.avatar];
    _nicknameLabel.text = teacherModel.nickname;
    _auth_textLabel.text = teacherModel.auth_text;
    _signatureLabel.text  = teacherModel.signature;
    if ([teacherModel.is_subscribe isEqualToString:@"0"]) {
        _attentionButton.layer.borderColor = kPinkColor.CGColor;
        [_attentionButton setTitle:@"+关注 " forState:(UIControlStateNormal)];
        [_attentionButton setTitleColor:kPinkColor forState:(UIControlStateNormal)];
    }else{
        _attentionButton.layer.borderColor = [UIColor grayColor].CGColor;
        [_attentionButton setTitle:@"已关注 " forState:(UIControlStateNormal)];
        [_attentionButton setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];  
    }
    
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
