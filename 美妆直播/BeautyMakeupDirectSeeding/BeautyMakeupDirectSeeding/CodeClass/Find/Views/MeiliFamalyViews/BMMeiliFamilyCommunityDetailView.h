//
//  BMMeiliFamilyCommunityDetailView.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BMMeiliFamilyCommunityDetailView : UIView

@property (nonatomic, strong) UITableView *tableView;//  背景大tableView  (上面有个表头和一个分组)
@property (nonatomic, strong) UIView *headerView;//  表头
@property (nonatomic, strong) UIView *avatarLineView;// 放置头像那一行的view  放在标题的bottom下面并加10
@property (nonatomic, strong) UILabel *activity_title;//  标题
@property (nonatomic, strong) UIImageView *avatarImgV;//  头像
@property (nonatomic, strong) UILabel *nicknameLable;//  昵称
@property (nonatomic, strong) UILabel *add_time;//  发布时间
@property (nonatomic, strong) UILabel *owner;//  楼主
@property (nonatomic, strong) UILabel *intro;//  介绍
@property (nonatomic, strong) NSMutableArray *img_listArr;//  存放img

//  接口 这里用来读取评论
@property (nonatomic, strong) NSString *activity_id;//  接口

@end
