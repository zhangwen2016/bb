//
//  BMAnchorRecommendModel.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <Foundation/Foundation.h>

// 该model是主播页面的荣誉榜 和人气主播的通用model

@interface BMAnchorRecommendModel : NSObject

@property(nonatomic, strong) NSString *uid;//  跳转到下个页面需要的uid(个人主页)
@property(nonatomic, strong) NSString *nickname;//  昵称
@property(nonatomic, strong) NSString *avatar;// 头像
@property(nonatomic, strong) NSString *fans_count;//  粉丝数目
@property(nonatomic, strong) NSString *course_count;
@property(nonatomic, strong) NSString *money_count;//  收益
@property(nonatomic, strong) NSString *signature;//  个性签名
@property(nonatomic, strong) NSString *vip;
@property(nonatomic, strong) NSString *fans_month_incr;
@property(nonatomic, strong) NSString *money_month_incr;
@property(nonatomic, strong) NSString *subscribe_status;
@property(nonatomic, strong) NSString *subscribe_count;//  人气
@property(nonatomic, strong) NSString *rank;// 排名

@end
