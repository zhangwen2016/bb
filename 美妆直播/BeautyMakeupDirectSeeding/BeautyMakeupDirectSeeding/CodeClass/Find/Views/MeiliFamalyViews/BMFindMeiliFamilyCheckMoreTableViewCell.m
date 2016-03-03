//
//  BMFindMeiliFamilyCheckMoreTableViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMFindMeiliFamilyCheckMoreTableViewCell.h"
#import "BMRequestManager.h"

@implementation BMFindMeiliFamilyCheckMoreTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _topic_imgBtn = [[UIImageView alloc] init];
       // _topic_imgBtn.userInteractionEnabled = YES;
        _topic_imgBtn.frame = CGRectMake(10, 10, kScreenWidth - 20, 200);
        [self.contentView addSubview:_topic_imgBtn];
    }
    return self;
}

- (void)setModel:(BMMeiliFamilyCheckMoreModel *)model
{
    [BMRequestManager downLoadImageView:_topic_imgBtn UrlString:model.topic_img];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
