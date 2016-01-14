//
//  BMMeiliFamilyCmtModel.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMMeiliFamilyCmtModel : NSObject

@property (nonatomic, strong)NSString *coment_level;//  评论论层
@property (nonatomic, strong)NSString *coment_id;//  评论id
@property (nonatomic, strong)NSString *comment_content;//  评论内容
@property (nonatomic, strong)NSArray *comment_pics;//  照片的数组
@property (nonatomic, strong)NSString *add_time;//  发布时间
@property (nonatomic, strong)NSString *uid;
@property (nonatomic, strong)NSString *nickname;//  用户昵称
@property (nonatomic, strong)NSString *figure;//  头像
@property (nonatomic, strong)NSNumber *is_top;
@property (nonatomic, strong)NSNumber *is_teacher;
@property (nonatomic, strong)NSNumber *is_signed;

@property (nonatomic, strong)NSDictionary *parent_comment;//  父级评论

@end
