//
//  BMSearchLiveCollectionViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMSearchLiveCollectionViewCell.h"

@implementation BMSearchLiveCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _live_coverImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 40)];
        [self.contentView addSubview:_live_coverImg];
        
        _live_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _live_coverImg.bottom + 10, _live_coverImg.width, 20)];
        _live_titleLabel.font = [UIFont systemFontOfSize:12];
       [self.contentView addSubview:_live_titleLabel];
    }
    return self;
}

- (void)setTeacherModel:(BMSearchTeacherModel *)teacherModel{
    [BMRequestManager downLoadImageView:_live_coverImg UrlString:teacherModel.live_cover];
    _live_titleLabel.text = teacherModel.live_title;
    
}




@end
