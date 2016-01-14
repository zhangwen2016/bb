//
//  BMMicroblogOneCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/14.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMMicroblogOneCell.h"

@implementation BMMicroblogOneCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _Dsbutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _Dsbutton.frame = CGRectMake(0, 0, kScreenWidth/2, 43);
        [self.contentView addSubview:_Dsbutton];
        
        _DsButtonImage = [[UIImageView alloc] initWithFrame:CGRectMake((_Dsbutton.width - 30)/2, (_Dsbutton.height - 20)/2, 20, 20)];
        _DsButtonImage.image = [UIImage imageNamed:@"kanzhibo"];
        [_Dsbutton addSubview:_DsButtonImage];
        
        
        _centreView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2, 5, 1, 43 - 10)];
        _centreView.alpha = 0.5;
        _centreView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_centreView];
        
        _pictureButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _pictureButton.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 41);
        [self.contentView addSubview:_pictureButton];
        
        _pictureButtonImage = [[UIImageView alloc] initWithFrame:CGRectMake((_pictureButton.width - 30)/2, (_pictureButton.height - 20)/2, 20, 20)];
        _pictureButtonImage.image = [UIImage imageNamed:@"qita01"];
        
        [_pictureButton addSubview:_pictureButtonImage];
        
        
        _maxDownView = [[UIView alloc] initWithFrame:CGRectMake(0, _Dsbutton.bottom, kScreenWidth, 4)];
        _maxDownView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_maxDownView];
        
        _mineDownView = [[UIView alloc] initWithFrame:CGRectMake(0, _Dsbutton.bottom, kScreenWidth/2, 4)];
        _mineDownView.backgroundColor = [UIColor magentaColor];
        [self.contentView addSubview:_mineDownView];
        
        
        
    }
    return self;
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
