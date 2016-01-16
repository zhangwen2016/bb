//
//  BMteacherRecommendTableViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMteacherRecommendTableViewCell.h"
#import "BMMicroblogVC.h"
@implementation BMteacherRecommendTableViewCell

- (void)setTeacherArray:(NSArray *)teacherArray{
    _teacherArray = teacherArray;
    [self loadSubView];
}
- (void)loadSubView{
    _bgScrollView = [[UIScrollView alloc] initWithFrame:self.contentView.frame];
    _bgScrollView.showsHorizontalScrollIndicator = NO;
    _bgScrollView.bounces = YES;
    [self.contentView addSubview:_bgScrollView];
    for (int i = 0; i < _teacherArray.count; i++) {
        BMButtonLabel *BL = [[BMButtonLabel alloc] initWithFrame:CGRectMake(20 + 90 * i, 20, 70, 80)];
        BMRecommendTeacherModel *model = _teacherArray[i];
        BL.upButton.frame = CGRectMake(0, 0, 70, 70);
        BL.upButton.layer.cornerRadius = 35;
        BL.upButton.layer.masksToBounds = YES;
        BL.downLabel.frame = CGRectMake(0, 75, 70, 10);
        BL.upButton.tag = 200 + i;
        [BL.upButton addTarget:self action:@selector(upButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [BMRequestManager downLoadButton:BL.upButton UrlString:model.avatar];
        BL.downLabel.text = model.nickname;
        
        [_bgScrollView addSubview:BL];
    };
    
    _bgScrollView.contentSize = CGSizeMake(20 + 90 * _teacherArray.count, self.contentView.height);
}

- (void)removeBgScrollView{
    [self.bgScrollView removeFromSuperview];
}

- (void)upButtonClick:(UIButton *)button{
  //  NSLog(@"%ld", (long)button.tag);
    
    
    BMRecommendTeacherModel *model = _teacherArray[button.tag - 200];
    if ([_delegate respondsToSelector:@selector(sendButtonModel:)]) {
        [_delegate sendButtonModel:model];
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
