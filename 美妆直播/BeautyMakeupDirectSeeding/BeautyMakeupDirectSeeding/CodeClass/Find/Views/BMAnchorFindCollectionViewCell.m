//
//  BMAnchorFindCollectionViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMAnchorFindCollectionViewCell.h"
#import "BMRequestManager.h"

@interface BMAnchorFindCollectionViewCell ()

@property (nonatomic, strong)UIImageView *avatarBtn;

@end

@implementation BMAnchorFindCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _avatarBtn = [[UIImageView alloc] init];;
        _avatarBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.contentView addSubview:_avatarBtn];
    }
    return self;
}

- (void)setModel:(BMAnchorFindModel *)model
{
    _model = model;
    [BMRequestManager downLoadImageView:_avatarBtn UrlString:model.img_url];
}


@end
