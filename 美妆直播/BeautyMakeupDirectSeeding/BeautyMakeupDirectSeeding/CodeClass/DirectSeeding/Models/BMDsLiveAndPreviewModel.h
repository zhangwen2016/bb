//
//  BMDsLiveAndPreviewModel.h
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMDsLiveAndPreviewModel : NSObject
/*
 正在直播和正在预告的model
 */

@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,strong) NSString *end_time;
@property (nonatomic,strong) NSString *live_cover;
@property (nonatomic,strong) NSString *live_id;
@property (nonatomic,strong) NSString *live_title;
@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *online_count;
@property (nonatomic,strong) NSString *start_time;
@property (nonatomic,strong) NSString *view_count;
@property (nonatomic,strong) NSString *subscribe_count;
@property (nonatomic,strong) NSString *signature;
@property (nonatomic,strong) NSString *subscribe_status;
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *image_url;

// 微博
@property (nonatomic,strong) NSString *add_time;
@property (nonatomic,strong) NSString *commend;
@property (nonatomic,strong) NSString *cover_height;
@property (nonatomic,strong) NSString *cover_url;
@property (nonatomic,strong) NSString *cover_width;
@property (nonatomic,strong) NSString *is_praise;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *video_time;
@property (nonatomic,strong) NSString *source_id;



@end
