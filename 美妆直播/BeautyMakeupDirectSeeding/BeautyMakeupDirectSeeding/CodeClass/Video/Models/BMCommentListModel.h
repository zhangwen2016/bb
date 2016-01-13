//
//  BMCommentListModel.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMCommentListModel : NSObject
@property (nonatomic, strong) NSString *coment_level;
@property (nonatomic, strong) NSString *coment_id;
@property (nonatomic, strong) NSString *comment_content;
@property (nonatomic, strong) NSArray *comment_pics;
@property (nonatomic, strong) NSString *add_time;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *figure;
@property (nonatomic, strong) NSNumber *is_top;
@property (nonatomic, strong) NSNumber *is_teacher;
@property (nonatomic, strong) NSNumber *is_signed;
@property (nonatomic, strong) NSDictionary *parent_comment;
@property (nonatomic, strong) BMCommentListModel *parentModel;
@end
