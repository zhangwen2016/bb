//
//  BMLoginState.m
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/19.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import "BMLoginState.h"

@implementation BMLoginState

+ (BMLoginState *)shareBMLoginState
{
    static BMLoginState *state = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //  执行的任务 再整个程序运行期间 只执行一次
        //  并且只允许 一个线程访问(自带 线程保护)
        state = [[BMLoginState alloc] init];
    });
    return state;
}

@end
