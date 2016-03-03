//
//  BMSearchTeacherModel.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMSearchTeacherModel.h"

@implementation BMSearchTeacherModel

// @property (nonatomic, strong) NSString *uid;


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"course_id"]) {
        _live_id = value;
    }
    if ([key isEqualToString:@"course_title"]) {
        _live_title = value;
    }
    
    if ([key isEqualToString:@"course_cover"]) {
        _live_cover = value;
    }

    
    
}
@end
