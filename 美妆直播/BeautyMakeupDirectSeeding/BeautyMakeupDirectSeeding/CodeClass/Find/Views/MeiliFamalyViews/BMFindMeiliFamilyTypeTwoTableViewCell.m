//
//  BMFindMeiliFamilyTypeTwoTableViewCell.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMFindMeiliFamilyTypeTwoTableViewCell.h"
#import "BMCommonMethod.h"
#import "BMRequestManager.h"
#define kImgVTag 1200


@implementation BMFindMeiliFamilyTypeTwoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubView];
    }
    return self;
}

- (void)addSubView{
    //  活动标题
    _activityTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 20)];
    _activityTitleLabel.font = [UIFont systemFontOfSize:kLargeFont];
    _activityTitleLabel.numberOfLines = -1;
    [self.contentView addSubview:_activityTitleLabel];
    
    
    //  添加三个图
    for (int i = 0; i < 3; i++) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10 + ((kScreenWidth - 40) / 3 + 10) * i, _activityTitleLabel.bottom + 10, (kScreenWidth - 40) / 3, (kScreenWidth - 40) / 3 / 18 * 13)];
        imgV.tag = kImgVTag + i;
        imgV.clipsToBounds = YES;
        [self.contentView addSubview:imgV];
    }
    
    _firstImgV = [self.contentView viewWithTag:kImgVTag];
    _secondImgV = [self.contentView viewWithTag:kImgVTag + 1];
    _thirdImgV = [self.contentView viewWithTag:kImgVTag + 2];


    
    //  添加时间
    _addTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_activityTitleLabel.left, _firstImgV.bottom + 10, kScreenWidth / 3, 20)];
    _addTimeLabel.font = [UIFont systemFontOfSize:kSmallFont];
    _addTimeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_addTimeLabel];
    
    //  评论的小图标
    _cmtImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 150, _addTimeLabel.top, 20, _addTimeLabel.height)];
    [self.contentView addSubview:_cmtImgV];
    NSString *cmtPath = [[NSBundle mainBundle] pathForResource:@"MeiliFamilyCmt" ofType:@"png"];
    _cmtImgV.image = [UIImage imageWithContentsOfFile:cmtPath];
    
    //  评论的数量
    _cmtLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cmtImgV.right + 10, _cmtImgV.top, 30, _cmtImgV.height)];
    _cmtLabel.font = [UIFont systemFontOfSize:kSmallFont];
    _cmtLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_cmtLabel];
    
    
    //  浏览的小图标
    _viewCountImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 100, _addTimeLabel.top, 20, _addTimeLabel.height)];
    [self.contentView addSubview:_viewCountImgV];
    NSString *viewPath = [[NSBundle mainBundle] pathForResource:@"meiliFamilyView" ofType:@"png"];
    _viewCountImgV.image = [UIImage imageWithContentsOfFile:viewPath];
    
    //  浏览的数量
    _viewCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(_viewCountImgV.right + 10, _cmtImgV.top, 50, _cmtImgV.height)];
    _viewCountLabel.font = [UIFont systemFontOfSize:kSmallFont];
    _viewCountLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_viewCountLabel];
    
}


- (void)setModel:(BMMeiliFamilyCommunityModel *)model
{
    _model = model;
    _activityTitleLabel.text = model.activity_title;
    [BMCommonMethod autoAdjustHeightLabel:_activityTitleLabel labelFontSize:kLargeFont];
    [self adjustTime];
    _firstImgV.top = _activityTitleLabel.bottom + 10;
    _secondImgV.top = _firstImgV.top;
    _thirdImgV.top = _secondImgV.top;
    NSArray *imageArr = (NSArray *)model.img_url;
    [BMRequestManager downLoadImageView:_firstImgV UrlString:imageArr[0]];
//    [BMRequestManager downLoadImageView:_secondImgV UrlString:imageArr[1]];
//    [BMRequestManager downLoadImageView:_thirdImgV UrlString:imageArr[2]];
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeImgFrame) userInfo:nil repeats:NO];
    
    _addTimeLabel.top = _firstImgV.bottom + 10;
    _cmtLabel.text = model.cmt_count;
    _viewCountLabel.text = model.view_count;
    
    _cmtLabel.top = _addTimeLabel.top;
    _cmtImgV.top = _addTimeLabel.top;
    _viewCountImgV.top = _addTimeLabel.top;
    _viewCountLabel.top = _addTimeLabel.top;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"PlaceHoldingImage" ofType:@"png"];
    [_firstImgV sd_setImageWithURL:imageArr[0] placeholderImage:[UIImage imageWithContentsOfFile:path] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self cutImage:_firstImgV.image ForImgV:_firstImgV];
    }];
    [_secondImgV sd_setImageWithURL:imageArr[1] placeholderImage:[UIImage imageWithContentsOfFile:path] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self cutImage:_secondImgV.image ForImgV:_secondImgV];
    }];
    [_thirdImgV sd_setImageWithURL:imageArr[2] placeholderImage:[UIImage imageWithContentsOfFile:path] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self cutImage:_thirdImgV.image ForImgV:_thirdImgV];
    }];
    
    //[self changeImgFrame];
}

- (void)changeImgFrame
{
    [self cutImage:_firstImgV.image ForImgV:_firstImgV];
    [self cutImage:_secondImgV.image ForImgV:_secondImgV];
    [self cutImage:_thirdImgV.image ForImgV:_thirdImgV];
}

//裁剪图片
- (void)cutImage:(UIImage*)image ForImgV:(UIImageView *)imgV
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (_firstImgV.frame.size.width / _firstImgV.frame.size.height)) {
        CGFloat size = imgV.frame.size.width / image.size.width;
        
        newSize.width = image.size.width;
        newSize.height = image.size.width * _firstImgV.frame.size.height / _firstImgV.frame.size.width;
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width / size, newSize.height / size));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * _firstImgV.frame.size.width / _firstImgV.frame.size.height;
    
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    imgV.image = [UIImage imageWithCGImage:imageRef];
}

////  调整图片大小
//- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
//    CGImageRef sourceImageRef = [image CGImage];
//    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
//    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
//    return newImage;
//}

//  调整时间
- (void)adjustTime
{
    long long int date1 = (long long int)[_model.add_time intValue];
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MM-dd HH:mm"];
    
    NSString *str = [formatter stringFromDate:date2];
    
    _addTimeLabel.text = [NSString stringWithFormat:@"%@",str];
}


+ (CGFloat)cellHeightWithModel:(BMMeiliFamilyCommunityModel *)model
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 20)];
    label.numberOfLines = -1;
    label.font = [UIFont systemFontOfSize:kLargeFont];
    label.text = model.activity_title;
    [BMCommonMethod autoAdjustHeightLabel:label labelFontSize:kLargeFont];
    return 50 + label.height + 20 + (kScreenWidth - 40) / 3 * 13 / 18;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
