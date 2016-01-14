//
//  BMVideoShowViewController.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/13.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMVideoMainModel.h"
@interface BMVideoShowViewController : UIViewController
// @property (nonatomic, strong) BMVideoMainModel *mainModel;
@property (nonatomic, strong) NSString *source_id;

- (void)reloadData;
@end
