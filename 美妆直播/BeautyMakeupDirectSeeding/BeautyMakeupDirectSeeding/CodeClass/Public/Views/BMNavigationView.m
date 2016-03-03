//
//  BMNavigationView.m
//  Temp
//
//  Created by 庄壮勇 on 16/1/9.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMNavigationView.h"

@implementation BMNavigationView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        
        _topToLeftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _topToLeftButton.frame = CGRectMake(width/2 - 65, 0, 45, height - 10);
        [_topToLeftButton setTitleColor:[UIColor magentaColor] forState:(UIControlStateNormal)];
        
        [self addSubview:_topToLeftButton];
        
        _topToView = [[UIView alloc] initWithFrame:CGRectMake(_topToLeftButton.left, _topToLeftButton.bottom, _topToLeftButton.width, 2)];
        _topToView.backgroundColor = [UIColor magentaColor];
        [self addSubview:_topToView];
        
        _topToRightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_topToRightButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        _topToRightButton.frame = CGRectMake(width/2 + 20, _topToLeftButton.top, _topToLeftButton.width, _topToLeftButton.height);
        
        [self addSubview:_topToRightButton];
        
        
        
        
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
