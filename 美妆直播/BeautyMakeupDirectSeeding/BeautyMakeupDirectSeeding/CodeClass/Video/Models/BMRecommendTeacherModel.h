//
//  BMRecommendTeacherModel.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMRecommendTeacherModel : NSObject
// 老师
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *vip;
@property (nonatomic, strong) NSString *fans_count;
@property (nonatomic, strong) NSString *subscribe_count;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *is_signed;
@end
