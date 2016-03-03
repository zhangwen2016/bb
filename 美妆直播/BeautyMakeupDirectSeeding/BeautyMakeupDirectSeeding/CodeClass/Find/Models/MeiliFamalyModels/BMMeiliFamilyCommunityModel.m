//
//  BMMeiliFamilyCommunityModel.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMMeiliFamilyCommunityModel.h"

@implementation BMMeiliFamilyCommunityModel

//  重写方法  防止抛出异常
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

@end
