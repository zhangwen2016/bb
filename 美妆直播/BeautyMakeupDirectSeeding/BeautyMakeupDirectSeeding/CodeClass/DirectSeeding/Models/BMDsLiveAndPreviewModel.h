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

@end
