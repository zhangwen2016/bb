//
//  BMLoginViewController.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/19.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BMLoginViewControllerDelegate <NSObject>

- (void)changeStateWithDidlogin;

@end


@interface BMLoginViewController : UIViewController

@property (nonatomic, assign) id<BMLoginViewControllerDelegate>delegate;

@end
