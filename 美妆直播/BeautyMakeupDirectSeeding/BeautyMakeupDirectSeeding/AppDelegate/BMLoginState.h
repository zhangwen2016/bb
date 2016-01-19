//
//  BMLoginState.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/19.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMLoginState : NSObject


+ (BMLoginState *)shareBMLoginState;

@property (nonatomic, assign)BOOL isLogin;//  已经登陆
@property (nonatomic, strong)NSString *sso;
@property (nonatomic, strong)NSString *uid;


@end
