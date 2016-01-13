//
//  BMVideoHotTag.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMVideoHotTagModel.h"
@interface BMVideoHotTag : UIView
@property (nonatomic, strong) NSArray *sourceArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIViewController *currentVC;
@end
