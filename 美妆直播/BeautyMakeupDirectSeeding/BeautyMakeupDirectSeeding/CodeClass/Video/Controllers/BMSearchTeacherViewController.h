//
//  BMSearchTeacherViewController.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/12.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMSearchTeacherViewController : UIViewController
@property (nonatomic, strong) NSString *keyWordString;
- (void)reloadData;
@end
