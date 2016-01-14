//
//  BMMicroblogModel.h
//  BeautyMakeupDirectSeeding
//
//  Created by 庄壮勇 on 16/1/14.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMMicroblogModel : NSObject

/*微博表头Model*/


@property (nonatomic,strong) NSString *auth_text;
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,strong) NSString *background_image;
@property (nonatomic,strong) NSString *course_count;
@property (nonatomic,strong) NSString *diamond;
@property (nonatomic,strong) NSString *fans_count;
@property (nonatomic,strong) NSString *follow_count;
@property (nonatomic,strong) NSString *grade;
@property (nonatomic,strong) NSString *ipad_bg_image;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *money_count;
@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *signature;
@property (nonatomic,strong) NSString *subscribe_status;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *vip;

// 集合视图
@property (nonatomic,strong) NSString *img_url;
@property (nonatomic,strong) NSString *img_height;
@property (nonatomic,strong) NSString *img_id;
@property (nonatomic,strong) NSString *img_width;









@end
