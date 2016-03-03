//
//  BMPersonDetailModel.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMPersonDetailModel : NSObject

// 主播的个人星系
@property (nonatomic, strong) NSString *course_id;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *tag_id;
@property (nonatomic, strong) NSString *category_id;
@property (nonatomic, strong) NSString *course_title;
@property (nonatomic, strong) NSString *keywords;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *course_video;
@property (nonatomic, strong) NSString *video_time;
@property (nonatomic, strong) NSString *course_content;
@property (nonatomic, strong) NSString *course_cover;
@property (nonatomic, strong) NSString *see_count;
@property (nonatomic, strong) NSArray *course_pics;
@property (nonatomic, strong) NSString *praise_count;
@property (nonatomic, strong) NSString *comment_count;
@property (nonatomic, strong) NSString *wallet_number;
@property (nonatomic, strong) NSString *relation_goods_id;
@property (nonatomic, strong) NSString *comment_number;
@property (nonatomic, strong) NSString *makeup_number;
@property (nonatomic, strong) NSArray *makeup_list;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *course_num;
@property (nonatomic, strong) NSString *subscribe_count;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *signature;
@property (nonatomic, strong) NSString *auth_text;
@property (nonatomic, strong) NSNumber *is_signed;
@property (nonatomic, strong) NSNumber *is_praise;
@property (nonatomic, strong) NSNumber *is_favorite;
@property (nonatomic, strong) NSNumber *is_subscribe;


@end
