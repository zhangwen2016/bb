//
//  BMCommonMethod.h
//  BeautyMakeupDirectSeeding
//
//  Created by lanou on 16/1/11.
//  Copyright © 2016年 YONG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMCommonMethod : NSObject
+ (void)autoAdjustHeightLabel:(UILabel *)label labelFontSize:(NSInteger)fontSize;
+ (void)autoAdjustLeftWidthLabel:(UILabel *)label labelFontSize:(NSInteger)fontSize;
+ (void)autoAdjustRightWidthLabel:(UILabel *)label labelFontSize:(NSInteger)fontSize;
+ (void)NoNetWorkInVC:(UIViewController *)VC;
@end
