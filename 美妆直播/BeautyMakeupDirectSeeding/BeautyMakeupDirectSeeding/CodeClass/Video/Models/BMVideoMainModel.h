//
//  BMVideoMainModel.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <Foundation/Foundation.h>
// Video的model
@interface BMVideoMainModel : NSObject
@property (nonatomic, strong) NSString *source_id;
@property (nonatomic, strong) NSString *commend;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *video_url;
@property (nonatomic, strong) NSString *video_time;
@property (nonatomic, strong) NSString *cover_width;
@property (nonatomic, strong) NSString *cover_height;
@property (nonatomic, strong) NSString *cover_url;
@property (nonatomic, strong) NSString *add_time;
@property (nonatomic, strong) NSString *release_time;
@property (nonatomic, strong) NSString *start_time;
@property (nonatomic, strong) NSString *online_user_num;
@property (nonatomic, strong) NSString *view_count;
@property (nonatomic, strong) NSString *praise_count;
@property (nonatomic, strong) NSString *subscribe_count;
@property (nonatomic, strong) NSString *is_signed;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *is_praise;
@end
