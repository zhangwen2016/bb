//
//  BMDsRightScrollView.m
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMDsRightScrollView.h"
#import "BMDsLiveAndPreviewModel.h"

@implementation BMDsRightScrollView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = frame.size.width;
        
        CGFloat height = frame.size.height;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30 , width, 30)];
        
        _titleLabel.text = @"您目前还没有关注哦~";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:kLargeFont];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.alpha = 0.3;
        [self addSubview:_titleLabel];
        
        _titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, _titleLabel.bottom, width, _titleLabel.height)];
        _titleLabel1.textAlignment = NSTextAlignmentCenter;
        _titleLabel1.text = @"我们为您推荐了热门主播";
        _titleLabel1.textColor = [UIColor grayColor];
        _titleLabel1.font = [UIFont systemFontOfSize:kLargeFont];
        _titleLabel1.alpha = 0.3;

        [self addSubview:_titleLabel1];
        
        // 头像宽度和高度
        CGFloat viewWidth = (width - 5 * 25)/4;
        
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 4; j++) {
                
                UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
                button.frame = CGRectMake(25 + j * (viewWidth + 25),_titleLabel1.bottom + 100 + i* (viewWidth + 100), viewWidth, viewWidth);
                button.layer.masksToBounds = YES;
                button.layer.cornerRadius = button.width/2;
                
                button.backgroundColor = [UIColor redColor];
                [self addSubview:button];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(button.left, button.bottom, button.width, 30)];
                label.text = @"愛疯中sdfjl";
                label.font = [UIFont systemFontOfSize:kLargeFont];
                label.textAlignment = NSTextAlignmentCenter;
                [self addSubview:label];
                
                // 设置tag值
                if (i == 0) {
                    button.tag = 10 + j;
                    label.tag = 20 + j;
                }else if (i == 1){
                    button.tag = 14 + j;
                    label.tag = 24 + j;
                }
                
            }
        }
        
        _avatarButton1 = (UIButton *)[self viewWithTag:10];
        _avatarButton2 = (UIButton *)[self viewWithTag:11];
        _avatarButton3 = (UIButton *)[self viewWithTag:12];
        _avatarButton4 = (UIButton *)[self viewWithTag:13];
        _avatarButton5 = (UIButton *)[self viewWithTag:14];
        _avatarButton6 = (UIButton *)[self viewWithTag:15];
        _avatarButton7 = (UIButton *)[self viewWithTag:16];
        _avatarButton7 = (UIButton *)[self viewWithTag:17];
        
        _nicknameLabel1 = (UILabel *)[self viewWithTag:20];
        _nicknameLabel2 = (UILabel *)[self viewWithTag:21];
        _nicknameLabel3 = (UILabel *)[self viewWithTag:22];
        _nicknameLabel4 = (UILabel *)[self viewWithTag:23];
        _nicknameLabel5 = (UILabel *)[self viewWithTag:24];
        _nicknameLabel6 = (UILabel *)[self viewWithTag:25];
        _nicknameLabel7 = (UILabel *)[self viewWithTag:26];
        _nicknameLabel8 = (UILabel *)[self viewWithTag:27];

        // 关注按钮
        _attentionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        _attentionButton.frame = CGRectMake(60, _nicknameLabel8.bottom + 70, width - 120, 50);
        [_attentionButton setTitle:@"关注" forState:(UIControlStateNormal)];
        _attentionButton.backgroundColor = [UIColor grayColor];
        _attentionButton.alpha = 0.3;
        [self addSubview:_attentionButton];
        
        
    }
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    for (int i = 0; i < dataArray.count; i++) {
        BMDsLiveAndPreviewModel *model = dataArray[i];
        UIButton * button = (UIButton *)[self viewWithTag:10 + i];
        UILabel *label = (UILabel *)[self viewWithTag:20 + i];
        
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.avatar] forState:(UIControlStateNormal)];
        label.text = model.nickname;
        
        
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
