//
//  BMButtonLabel.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMButtonLabel.h"

@implementation BMButtonLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _upButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _upButton.frame = CGRectMake(0 , 0, frame.size.width, frame.size.height / 2);
        [_upButton setTitleColor:kPinkColor forState:(UIControlStateNormal)];
        _upButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_upButton];
        
        _downLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _upButton.bottom, _upButton.width, _upButton.height)];
        _downLabel.font = [UIFont systemFontOfSize:10];
        _downLabel.textColor = [UIColor grayColor];
        _downLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:_downLabel];
        
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
