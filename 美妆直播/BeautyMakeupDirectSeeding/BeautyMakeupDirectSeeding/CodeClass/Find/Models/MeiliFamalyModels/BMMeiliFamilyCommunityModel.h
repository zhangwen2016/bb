//
//  BMMeiliFamilyCommunityModel.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMMeiliFamilyCommunityModel : NSObject

@property (nonatomic, strong) NSString *activity_id;
@property (nonatomic, strong) NSString *activity_title;//  活动标题
@property (nonatomic, strong) NSString *add_time;//  添加时间
@property (nonatomic, strong) NSString *top;
@property (nonatomic, strong) NSString *essence;
@property (nonatomic, strong) NSString *hot;
@property (nonatomic, strong) NSString *cmt_count;//  评论数量
@property (nonatomic, strong) NSString *view_base;
@property (nonatomic, strong) NSString *view_count;//  多少人看过
@property (nonatomic, strong) NSArray *img_url;//  放照片url的数组
@property (nonatomic, strong) NSString *list_show_type;//  cell的种类
@property (nonatomic, strong) NSString *latest;
@property (nonatomic, strong) NSString *redirect_url;


@end
