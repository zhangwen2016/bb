//
//  BMMeiiFamilyCommentTableViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMMeiiFamilyCommentTableViewCell.h"
#import "BMRequestManager.h"
#import "BMCommonMethod.h"

#define ZWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation BMMeiiFamilyCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubView];
    }
    return self;
}


- (void)addSubView{
    //  头像
    _avatarImgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    [self.contentView addSubview:_avatarImgV];
    
    //  昵称
    _nicknameLable = [[UILabel alloc] initWithFrame:CGRectMake(_avatarImgV.right + 5, 0, 200, 20)];
    _nicknameLable.font = [UIFont systemFontOfSize:kLargeFont];
    _nicknameLable.textAlignment = NSTextAlignmentLeft;
    _nicknameLable.textColor = [UIColor magentaColor];
    [self.contentView addSubview:_nicknameLable];
    
    //  发布时间
    _add_time = [[UILabel alloc] initWithFrame:CGRectMake(_nicknameLable.left, _nicknameLable.bottom + 5, _nicknameLable.width, 15)];
    _add_time.font = [UIFont systemFontOfSize:kSmallFont];
    _add_time.textAlignment = NSTextAlignmentLeft;
    _add_time.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_add_time];
    
    //  楼层
    _coment_level = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 110, 15, 100, 15)];
    _coment_level.font = [UIFont systemFontOfSize:kSmallFont];
    _coment_level.text = @"楼主";
    _coment_level.textAlignment = NSTextAlignmentRight;
    _coment_level.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_coment_level];
    
    
    // 评论
    _comment_content = [[UILabel alloc] initWithFrame:CGRectMake(10, _avatarImgV.bottom + 10, kScreenWidth - 20, 100)];
    _comment_content.numberOfLines = -1;
    _comment_content.font = [UIFont systemFontOfSize:kSmallFont];
    [self.contentView addSubview:_comment_content];
    
    //  父级评论
    _parentView = [[UIView alloc] initWithFrame:CGRectMake(10, _comment_content.bottom + 10, kScreenWidth - 20, 60)];
    _parentView.backgroundColor = ZWColor(253, 241, 246);
    [self.contentView addSubview:_parentView];
    
    _parent_nickname = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    _parent_nickname.font = [UIFont systemFontOfSize:kLargeFont];
    _parent_nickname.textColor = [UIColor magentaColor];
    [_parentView addSubview:_parent_nickname];
    
    _parent_cmt = [[UILabel alloc] initWithFrame:CGRectMake(_parent_nickname.left, _parent_nickname.bottom + 10, kScreenWidth - 40, 20)];
    _parent_cmt.font = [UIFont systemFontOfSize:kSmallFont];
    [_parentView addSubview:_parent_cmt];
    
    _cmtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cmtBtn.frame = CGRectMake(kScreenWidth - 40, _parentView.bottom + 10, 30, 30);
    NSString *cmtPath = [[NSBundle mainBundle] pathForResource:@"SmallCmtImg" ofType:@"png"];
    [_cmtBtn setBackgroundImage:[UIImage imageWithContentsOfFile:cmtPath] forState:UIControlStateNormal];
    [self.contentView addSubview:_cmtBtn];
    
    
}

- (void)setModel:(BMMeiliFamilyCmtModel *)model
{
    [BMRequestManager downLoadImageView:_avatarImgV UrlString:model.figure];
    _avatarImgV.layer.cornerRadius = _avatarImgV.width / 2;
    _avatarImgV.layer.masksToBounds = YES;
    _nicknameLable.text = model.nickname;
    _add_time.text = model.add_time;
    _coment_level.text = [NSString stringWithFormat:@"%@楼", model.coment_level];
    _comment_content.top = _avatarImgV.bottom + 10;
    _comment_content.text = model.comment_content;
    [BMCommonMethod autoAdjustHeightLabel:_comment_content labelFontSize:kSmallFont];
    _cmtBtn.top = _comment_content.bottom + 10;
    
    if (model.comment_pics.count == 0 ) {
        if (_cmtPic != nil) {
            [_cmtPic removeFromSuperview];
        }
    }else{
        _cmtPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, _comment_content.bottom + 10, kScreenWidth - 20, 400)];
        [self.contentView addSubview:_cmtPic];
        [BMRequestManager downLoadImageView:_cmtPic UrlString:model.comment_pics[0][0]];
        _cmtBtn.top = _cmtPic.bottom + 10;

    }
    
    
    if (model.parent_comment == nil) {
        if (_parentView != nil ) {
            [_parentView removeFromSuperview];
        }
    }else{
        
        _parent_nickname.text = model.parent_comment[@"nickname"];
        _parent_cmt.text = model.parent_comment[@"comment_content"];
        [BMCommonMethod autoAdjustHeightLabel:_parent_cmt labelFontSize:kSmallFont];
        _parentView.top = _comment_content.bottom + 10;
        _parentView.height = 50 + _parent_cmt.height;
        _cmtBtn.top = _parentView.bottom + 5;

    }
}

+ (CGFloat)heightForCellWithModel:(BMMeiliFamilyCmtModel *)model
{
    
    CGFloat addHeight = 0;
    
    // 评论
    UILabel *comment_content = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 100)];
    comment_content.numberOfLines = -1;
    comment_content.font = [UIFont systemFontOfSize:kSmallFont];
    comment_content.text = model.comment_content;
    [BMCommonMethod autoAdjustHeightLabel:comment_content labelFontSize:kSmallFont];
    
    addHeight += comment_content.height;
    
    if (model.comment_pics.count == 0 ) {
        
    }else{
        addHeight += 400 +10;
    }
    
    
    if (model.parent_comment == nil) {
       
    }else{
    
        UILabel *parent_cmt = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, kScreenWidth - 40, 20)];
        parent_cmt.font = [UIFont systemFontOfSize:kSmallFont];
        parent_cmt.text = model.parent_comment[@"comment_content"];
        [BMCommonMethod autoAdjustHeightLabel:parent_cmt labelFontSize:kSmallFont];
        addHeight = 50 + parent_cmt.height +10;
        
    }

    
    return addHeight + 70 + 20 + 10;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
