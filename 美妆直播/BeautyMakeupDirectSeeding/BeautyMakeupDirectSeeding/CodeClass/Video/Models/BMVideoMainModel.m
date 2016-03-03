//
//  BMVideoMainModel.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMVideoMainModel.h"

@implementation BMVideoMainModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
        if ([key isEqualToString:@"course_id"]) {
            _source_id = value;
        }else if ([key isEqualToString:@"course_cover"]){
            _cover_url = value;
        }
        if ([key isEqualToString:@"course_video"]) {
            _video_url = value;
        }
        if ([key isEqualToString:@"course_title"]) {
            _title = value;
        }
}
@end
