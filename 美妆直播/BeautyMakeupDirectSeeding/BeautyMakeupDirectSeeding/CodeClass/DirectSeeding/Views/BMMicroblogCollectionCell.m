//
//  BMMicroblogCollectionCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/14.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMMicroblogCollectionCell.h"

@implementation BMMicroblogCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = frame.size.width;
        
        CGFloat height = frame.size.height;
        
        _img_urlButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _img_urlButton.frame = CGRectMake(0, 0, width, height);
        [self addSubview:_img_urlButton];
        
    }
    return self;
}

- (void)setModel:(BMMicroblogModel *)model
{
    [BMRequestManager downLoadButton:_img_urlButton UrlString:model.img_url];
}


@end
