//
//  BMPersonDetailModel.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMPersonDetailModel.h"

@implementation BMPersonDetailModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"live_id"]) {
        _course_id = value;
    }
    if ([key isEqualToString:@"live_title"]) {
        _course_title = value;
    }
    
    if ([key isEqualToString:@"live_cover"]) {
        _course_cover = value;
    }
    if ([key isEqualToString:@"wallet_total"]) {
        _wallet_number = value;
    }
    
    if ([key isEqualToString:@"view_count"]) {
        _see_count = value;
    }
    
}

@end
