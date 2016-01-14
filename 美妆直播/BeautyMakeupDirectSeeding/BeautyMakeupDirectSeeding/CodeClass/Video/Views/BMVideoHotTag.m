//
//  BMVideoHotTag.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMVideoHotTag.h"
#import "BMVideoHotTagViewController.h"
@interface BMVideoHotTag ()
@property (nonatomic, assign) CGFloat lastWidth;

@end
@implementation BMVideoHotTag
- (void)setSourceArray:(NSArray *)sourceArray{
    _sourceArray = sourceArray;
    [self loadTagButton];
}




- (void)loadTagButton{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height)];
    [self addSubview:_scrollView];
    NSInteger line = 0;
    CGFloat orginX = 0;
    
    for (int i = 0; i < _sourceArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        BMVideoHotTagModel *model = _sourceArray[i];
        [button setTitle:model.name forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        // button.backgroundColor = [UIColor orangeColor];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        // 设置button 的位置
        CGFloat width = [self autoWidthbutton:button FontSize:12] + 20;
        CGFloat height = 30;
        orginX = 5 + _lastWidth + orginX; // X者的位置
        if (self.frame.size.width - orginX < width) {
            line += 1;
            orginX = 5;
        }
        CGFloat orginY = 10 + line * (height + 10);
        button.frame = CGRectMake(orginX, orginY, width, height);
        button.layer.cornerRadius = 10 ;
        button.layer.borderColor =[UIColor lightGrayColor].CGColor;
        button.layer.borderWidth = 0.5;
        _lastWidth = width;
        [_scrollView addSubview:button];
    }
    
    // 得到最后一个button的位置 设置scrollView 的size
    UIButton *button = [self viewWithTag:_sourceArray.count - 1];
    _scrollView.contentSize = CGSizeMake(self.frame.size.width, button.frame.origin.y + button.frame.size.height + 20);
    
    
    
}

- (CGFloat)autoWidthbutton:(UIButton *)button FontSize:(NSInteger)fontSize{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize], NSFontAttributeName,nil];
    CGRect frame = [button.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, button.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return frame.size.width;
}

- (void)buttonClick:(UIButton *)button{
//    NSArray *childArray = [_currentVC.view subviews];
//    for (id VC in childArray) {
//        if ([VC isKindOfClass:[UISearchBar class]]) {
//            [VC resignFirstResponder];
//          //  [VC removeFromParentViewController];
//        }
//    }
    BMVideoHotTagViewController *hotTagVC = [[BMVideoHotTagViewController alloc] init];
    hotTagVC.hotTagModel = _sourceArray[button.tag];
    [_currentVC.navigationController pushViewController:hotTagVC animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
