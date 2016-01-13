//
//  BMSearchTeacherModel.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMSearchTeacherModel : NSObject
// teacher
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *auth_text;
@property (nonatomic, strong) NSString *signature;
@property (nonatomic, strong) NSString *course_count;
@property (nonatomic, strong) NSString *money_count;
@property (nonatomic, strong) NSNumber *is_signed;
@property (nonatomic, strong) NSString *is_subscribe;



// course 和MainMModel一样
//@property (nonatomic, strong) NSString *course_id;
//// @property (nonatomic, strong) NSString *uid;
//@property (nonatomic, strong) NSString *course_title;
//@property (nonatomic, strong) NSString *course_video;
//@property (nonatomic, strong) NSString *video_time;
//@property (nonatomic, strong) NSString *course_cover;
//// @property (nonatomic, strong) NSString *nickname;
//// @property (nonatomic, strong) NSString *avatar;
//@property (nonatomic, strong) NSString *subscribe_count;
//@property (nonatomic, strong) NSString *see_count;
//@property (nonatomic, strong) NSString *add_time;
//@property (nonatomic, strong) NSString *praise_count;

// live
@property (nonatomic, strong) NSString *live_id;
@property (nonatomic, strong) NSString *live_title;
@property (nonatomic, strong) NSString *live_cover;
@property (nonatomic, strong) NSString *start_time;
@property (nonatomic, strong) NSString *end_time;
@property (nonatomic, strong) NSString *online_user_num;
@property (nonatomic, strong) NSString *view_count;
//@property (nonatomic, strong) NSString *praise_count; // 重复部分
@property (nonatomic, strong) NSString *status;
// @property (nonatomic, strong) NSString *nickname;
// @property (nonatomic, strong) NSString *avatar;
// @property (nonatomic, strong) NSString *uid;
//@property (nonatomic, strong) NSNumber *is_signed;
//@property (nonatomic, strong) NSString *subscribe_count;


@end
