//
//  BMFindAnchorHonerListTableViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMFindAnchorHonerListTableViewCell.h"
#import "BMRequestManager.h"
#define kAvatarImgTag 40000

@implementation BMFindAnchorHonerListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview];
        //  显示右方小箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)addSubview {
    
    _logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth / 10, 50)];
    _logoImg.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_logoImg];
    
    
    _titleLable =[[UILabel alloc] initWithFrame:CGRectMake(_logoImg.right + 10, 10, kScreenWidth * 3 / 10, _logoImg.height)];

    [self.contentView addSubview:_titleLable];
    
    _thirdAvatarImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 10 - 50 - 20, 10, 50, 50)];
    _thirdAvatarImg.tag = kAvatarImgTag + 2;
    [self.contentView addSubview:_thirdAvatarImg];
    
    _secondAvatarImg = [[UIImageView alloc] initWithFrame:CGRectMake(_thirdAvatarImg.left - 50, _thirdAvatarImg.top, 50, 50)];
    _secondAvatarImg.tag = kAvatarImgTag + 1;
    [self.contentView addSubview:_secondAvatarImg];
    
    _firstAvatarImg = [[UIImageView alloc] initWithFrame:CGRectMake(_secondAvatarImg.left - 50, _secondAvatarImg.top, 50, 50)];
    _firstAvatarImg.tag = kAvatarImgTag + 0;
    [self.contentView addSubview:_firstAvatarImg];
    
}

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    for (int i = 0; i < dataArr.count; i++) {
        BMAnchorRecommendModel *model = dataArr[i];
        UIImageView *imageV = [self.contentView viewWithTag:kAvatarImgTag + i];
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = imageV.frame.size.width / 2;
        [BMRequestManager downLoadImageView:imageV UrlString:model.avatar];
        NSLog(@"%@", imageV);
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
